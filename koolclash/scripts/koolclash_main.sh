#!/bin/sh
########################################
### 功能: 
###     1.管理节点添加、删除功能
###     2.上传、订阅启动配置文件的格式检测
###
###
########################################


export KSROOT=/koolshare
source $KSROOT/scripts/base.sh

# 环境变量定义

alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
eval $(dbus export koolclash_)

# LAN和WAN网卡IP地址信息
lan_ip=$(uci get network.lan.ipaddr)
# 没有用到 wan_ip=$(uci show network.wan.ipaddr 2>/dev/null)

# 配置文件信息
config_file="$KSROOT/koolclash/config/config.yaml"
origin_file="$KSROOT/koolclash/config/origin.yml"
backup_file="$KSROOT/koolclash/config/origin-backup.yml"
dns_file="$KSROOT/koolclash/config/dns.yml"
provider_diy_file="$KSROOT/koolclash/config/providers/provider_diy.yaml"
tmp_node_file="/tmp/upload/tmp_diy_node.yaml"
db_file="$KSROOT/koolclash/config/Country.mmdb"

rule_whitelist="$KSROOT/koolclash/config/ruleset/_whitelist.yaml"
rule_blacklist="$KSROOT/koolclash/config/ruleset/_blacklist.yaml"


main_script="$KSROOT/scripts/koolclash_main.sh"
default_test_node="proxies:\n- name:  "test"\n    type:  ss\n    server:  127.0.0.1\n    port:  9999\n    password:  123456\n    cipher:  aes-256-gcm"

redir_port=23456        # 代理转发端口
dns_port=23453          # DNS服务端口
ui_port=6170            # Restful API访问接口



curl=$(which curl)
wget=$(which wget)


# 如果没有外部监听控制就使用 LAN IP:6170
if [ ! -n "$koolclash_api_host" ]; then
    dbus remove koolclash_api_host
    ext_control_ip=$lan_ip
else
    ext_control_ip=$koolclash_api_host
fi

HTTP_OK="ok"


#----------------通用的功能函数定义

# 强制覆盖 DNS的设置
overwrite_dns_config() {
    # 确保启用 DNS
    yq e -i '.dns.enable=true' $config_file
    # 修改端口
    dns_port="0.0.0.0:$dns_port" yq e -i '.dns.listen=strenv(dns_port)' $config_file
    # 修改模式
    yq e -i '.dns.enhanced-mode="redir-host"' $config_file
    # Fake IP Range
    # yq e -iP '.dns.fake-ip-range="198.18.0.1/16"' $config_file
}

# 根据 $origin_file 生成 $config_file
generate_config_file() {

    echo_date "开始生成 $config_file ..."
    yq e -iP $origin_file
    cp $origin_file $config_file
    echo_date "设置 redir-port 转发端口为 $redir_port 和 allow-lan : 允许局域网连接"
    # 覆盖配置文件中的 redir-port 和 allow-lan 的配置
    redir_port=$redir_port yq e -i '.redir-port=env(redir_port)' $config_file
    yq e -i '.allow-lan=true' $config_file
    eip="$ext_control_ip:6170" yq e -iP '.external-controller=strenv(eip)' $config_file
    # 启用 external-ui
    yq e -iP '.external-ui="/koolshare/webs/koolclash/"' $config_file
    # 获取API访问密钥
    dbus set koolclash_api_secret="$(yq e '.secret' $config_file)"
}

# 验证 订阅配置文件 和 上传配置文件 有效性
check_config_file() {
    
    init_flag="$1"      # 第一次安装时调用
    echo_date "开始验证 配置文件 有效性 ..."

    # 判断是否存在 DNS 字段、DNS 是否启用、DNS 是否使用 redir-host / fake-ip 模式
    dns_emode=$(yq e '.dns.enhanced-mode' $config_file)
    dns_enable="$(yq e '.dns.enable' $config_file)"
    
    if [ "$dns_enable" == 'true' ] && [[ "$dns_emode" == 'fake-ip' || "$dns_emode" == 'redir-host' ]]; then
        if [ "$koolclash_dnsmode" == "2" ] && [ -n "$fallbackdns" ]; then
            # dnsmode 是 2 应该用自定义 DNS 配置进行覆盖
            echo_date "删除 Clash 配置文件中原有的 DNS 配置"
            yq e -i 'del(.dns)' $config_file

            echo_date "将提交的自定义 DNS 设置覆盖 Clash 配置文件..."
            # 将后备 DNS 配置以覆盖的方式与 config.yaml 合并
            yq ea -iP 'select(fi==1).dns as $dns| select(fi==0)|.dns = $dns' $config_file $dns_file
            dbus set koolclash_dnsmode=2
        else
            # 可能 dnsmode 是 2 但是没有自定义 DNS 配置；或者本来之前就是 1
            dbus set koolclash_dnsmode=1
        fi

        overwrite_dns_config
        echo_date "Clash 配置文件上传成功！"
        [[ -n "$init_flag" ]] || http_response $HTTP_OK

    else
        echo_date "在 Clash 配置文件中没有找到 DNS 配置！"

        if [ ! -n "$fallbackdns" ]; then
            echo_date "没有找到后备 DNS 配置！请前往「配置文件」提交后备 DNS 配置！"
            # 设置 DNS Mode 为 3
            dbus set koolclash_dnsmode=3
            [[ -n "$init_flag" ]] || http_response 'nofallbackdns'
        else
            echo_date "找到后备 DNS 配置！合并到 Clash 配置文件中..."

            dbus set koolclash_dnsmode=4
            # 将后备 DNS 配置以覆盖的方式与 config.yaml 合并
            echo_date "删除 Clash 配置文件中原有的 DNS 配置"
            yq e -i 'del(.dns)' $config_file
            yq ea -iP 'select(fi==1).dns as $dns| select(fi==0)|.dns = $dns' $config_file $dns_file

            overwrite_dns_config

            echo_date "Clash 配置文件上传成功！"
            [[ -n "$init_flag" ]] || http_response $HTTP_OK
        fi
    fi
}

#--------- 外部调用的功能 --------------------------------------------



# 对上传的启动配置文件进行 验证、配置参数设置等
upload_config_file() {
    # 使用方法: upload_config_file

    upload_file="/tmp/upload/clash.config.yaml"

    # 检测是否能够读取面板上传的 Clash
    if [ ! -f "$upload_file" ]; then
        echo_date "没有找到上传的配置文件！退出！"
        http_response 'notfound'
        exit 1
    fi

    echo_date "开始上传配置！"
    mkdir -p $KSROOT/koolclash/config/
    # 将上传的文件复制到 Config 目录中
    mv $upload_file $origin_file

    # 生成 config.yaml 启动配置文件
    generate_config_file

    # 检验 config.yaml 配置文件有效性
    check_config_file
}

# 修改Restful API访问的接口IP地址
change_external_controller_ip() {
    new_ip="$1"
    if [ ! -n "$new_ip" ]; then
        dbus set koolclash_api_host=$lan_ip
        ext_control_ip=$lan_ip
    else
        dbus set koolclash_api_host=$new_ip
        ext_control_ip=$new_ip
    fi

    eip="$ext_control_ip:$ui_port" yq e -iP '.external-controller=strenv(eip)' $config_file
    if [ "$?" == "0" ] ; then
        http_response $HTTP_OK
    else
        http_response "error"
    fi
}


# 订阅URL信息删除
sub_delete() {
    dbus remove koolclash_suburl
    http_response 'ok'
}

# 订阅URL下载并更新启动配置文件
sub_update() {
    url=$(echo "$1" | base64 -d)

    if [ "$url" == "" ]; then
        # 你提交个空的上来干嘛？是不是想删掉？
        dbus remove koolclash_suburl
        http_response $HTTP_OK
    else
        dbus set koolclash_suburl="$url"

        if [ "x$curl" != "x" ] && [ -x $curl ]; then
            mv $origin_file $backup_file
            $curl -L "$url" -o $origin_file
        else
            http_response 'nocurl'
            return 1
        fi

        rport=$(yq e '.redir-port' $origin_file)
        if [ "$?" != "0" ]; then
            http_response "invalid_yaml_format"
            return 2
        fi
        if [ "$rport" == "null" -o "$rport" == "" ]; then
            # 下载成功，但缺少redir-port，可能不是启动配置文件,仅仅是代理节点的订阅地址
            cp -p $backup_file $origin_file && rm -f $backup_file
            http_response "redir-port-not-found"
            return 3

        else # 下载成功了，先进行一下格式优化处理
            # 根据 $origin_file 生成 $config_file
            generate_config_file

            # 验证文件有效性
            check_config_file

        fi
    fi
}

# 添加IP白名单(直连)
firewall_white_ip_add() {
    dbus set koolclash_firewall_whiteip_base64="$3"
    http_response $HTTP_OK
}

#### DIY节点管理模块 定义开始

# DIY节点 获取节点名称列表
node_list() {
    init_flag="$1"
    filename="$provider_diy_file"
    node_list=`yq e '.proxies[].name' $filename| awk '!/test/{ printf("%s ", $0)}'`
    echo_date "DIY节点列表: [${node_list}]"
    dbus set koolclash_node_list="$node_list"
    [[ -n "$init_flag" ]] || http_response 'ok'
}

# 添加DIY节点
node_add() {

    uri_decoder=$(which uridecoder)
    if [ "$uri_decoder" == "" ] ; then
        echo_date "uri_decoder not found"
        http_response "error"
        return 1
    elif [ ! -x "$uri_decoder" ] ; then
        echo_date "uri_decoder not exexutable"
        http_response "error"
        return 2
    fi

    if [ ! -s "$provider_diy_file" ] ; then
        mkdir -p $(dirname $provider_diy_file)
        
        # 添加test节点(占位，否则无法启动clash)
        echo "$default_test_node" > $provider_diy_file
    fi

    uri=$(echo "$1"| base64 -d)

    # uri 格式识别(支持http(s)://开头节点订阅源 和 单个代理节点,格式如ss://,ssr://,vmess://)
    prefix="${uri:0:4}"  # 截取前四位字符判断
    if [ "$prefix" == "http" ] ; then
        # 网络代理节点订阅地址:下载配置信息、提取 proxies内所有节点、生成 $tmp_node_file 文件
        # 这里 使用yq 过滤处理一次目的是 格式验证 以及过滤掉无关信息.
        tmp_uri_file="/tmp/koolclash_temp_curl_uri.txt"
        $curl -o $tmp_uri_file -L $uri
        status="$?"
        if [ "$status" != "0" ] ; then
            echo_date "下载失败,curl返回结果[$status],订阅地址[$uri]"
            http_response "error_curl"
            return 2
        else
            node_num=$(yq e '.proxies[].name' "$tmp_node_file"|wc -l)
            if [ "$node_num" == "0" ] ; then
                # 2. base64加密或明文的URI节点列表
                echo_date "订阅地址没找到 .proxies 节点组, 正在检测是否为base64加密的节点列表 ..."
                $uri_decoder -db $db_file -ifile "$tmp_uri_file" > "$tmp_node_file"
                if [ "$?" != "0" ] ; then
                    echo_date "订阅URL地址解析失败!不识别的格式！"
                    http_response "decode_error"
                    return 2
                fi
            fi
        fi
    elif [ "$prefix" == "ss:/" -o "$prefix" == "ssr:" -o "$prefix" == "vmes" ] ; then
        $uri_decoder -db $db_file -uri "$uri" > "$tmp_node_file"
    else
        echo_date "不识别的格式: $uri"
        http_response "invalid_uri"
        return 2
    fi
    
    if [ "$?" != "0" ] ; then
        echo_date "抱歉!你添加的链接解析失败啦!给个正确的链接吧!"
        http_response "error_uri"
        return 2
    fi
    node_num=$(yq e '.proxies[].name' "$tmp_node_file"|wc -l)
    if [ "$node_num" == "0" ] ; then
        echo_date "解析结果正常，但没有发现任何节点被添加!"
        http_response $HTTP_OK
        return 0
    fi
    echo_date "成功提取[$node_num]个DIY代理节点临时文件: $tmp_node_file "

    cp $provider_diy_file $provider_diy_file.old
    yq_expr='select(fi==1).proxies as $plist | select(fi==0)|.proxies += $plist'
    yq ea -iP "$yq_expr" ${provider_diy_file} ${tmp_node_file}
    if [ "$?" != "0" ] ; then
        echo_date "怎么会这样! 添加DIY代理节点失败啦!"
        return 2
    fi
    echo_date "添加DIY节点成功!"
    rm -f ${tmp_node_file} ${provider_diy_file}.old
    node_list
}


# DIY节点 删除一个节点
node_delete_one() {
    clash_delete_name="$(echo "$1"| base64 -d)"
    filename="$provider_diy_file"
    cp $filename $filename.old
    echo_date "开始删除DIY节点 (${clash_delete_name}):"
    f=${clash_delete_name} yq e -i 'del(.proxies[]|select(.name == strenv(f)))' $filename
    # f=${clash_delete_name} yq e -i 'del(.proxy-groups[].proxies[]|select(. == strenv(f)))' $filename
    echo_date "节点删除完成!"
    node_list
}

# DIY节点 全部删除
node_delete_all() {
    filename="$provider_diy_file"
    cp $filename $filename.old
    echo_date "开始清理所有DIY节点:"

    # 偷个懒: 重置DIY配置文件只包含 test节点 就可以了。
    echo "$default_test_node" > $provider_diy_file

    # for fn in ${koolclash_node_list}
    # do
    #     # 保留 test 节点，删掉后添加节点会很出问题的哦!
    #     if [ $fn != "test" ] ; then
    #         f="$fn" yq e -i 'del(.proxies[]|select(.name == strenv(f)))' $filename
    #     fi
    # done
    echo_date "清理DIY节点完毕!让世界回归平静!"
    node_list
}


### DIY节点管理模块 结束

# 更新 Country.mmdb 文件
koolclash_update_mmdb() {

    url="https://cdn.jsdelivr.net/gh/alecthw/mmdb_china_ip_list@release/Country.mmdb"
    fname="/tmp/Country.mmdb"

    rm -rf /tmp/upload/koolclash_log.txt && touch /tmp/upload/koolclash_log.txt
    sleep 1

    if [ "x$wget" != "x" ] && [ -x $wget ]; then
        command="wget --no-check-certificate -O $fname -c $url"
    elif [ "x$curl" != "x" ] && [ test -x $curl ]; then
        command="$curl -k -o $fname $url"
    else
        echo_date "没有找到 wget 或 curl，无法更新 IP 数据库！" >>/tmp/upload/koolclash_log.txt
        http_response 'nodl'
        exit 1
    fi

    echo_date "开始下载最新 IP 数据库..." >>/tmp/upload/koolclash_log.txt

    echo_date "执行命令:[$command]" >>/tmp/upload/koolclash_log.txt
    # 更新Country.mmdb(全量版本IP数据)
    $command

    if [ "$?" != "0" ] ; then
        echo_date "下载 IP 数据库文件失败！执行下载命令出错了!" >>/tmp/upload/koolclash_log.txt
        exit 1
    fi

    if [ ! -f "$fname" ]; then
        echo_date "下载 IP 数据库失败！" >>/tmp/upload/koolclash_log.txt
        exit 1
    fi

    mmdb_file="$KSROOT/koolclash/config/Country.mmdb"

    mv ${mmdb_file} ${mmdb_file}.bak && mv $fname ${mmdb_file}
    dbus set koolclash_ipdb_version=$(date +%Y%m%d)

    if [ "$?" != "0" ] ; then
        echo_date "IP 数据库文件更新失败,可能是缺少文件或者磁盘空间满了！" >>/tmp/upload/koolclash_log.txt
        exit 1
    fi

    echo_date "IP 数据库更新完成！" >>/tmp/upload/koolclash_log.txt
    echo_date "注意！新版 IP 数据库将在下次启动 Clash 时生效！" >>/tmp/upload/koolclash_log.txt

    sleep 1

    echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt

    http_response 'ok'
    exit 0

}

koolclash_watchdog_enable() {
    dbus set koolclash_watchdog_enable=$1
    http_response "ok"
}

################################ proxy-provider管理模块 ##########

proxy_provider_list() {
    pp_list="$(yq e '.proxy-providers[]|key' $config_file)"
    
}

################################ proxy-provider管理模块 END ##########
start_cfddns(){
    # 配置检测
    [[ -z "$koolclash_cfddns_email" ]]  && echo_date "email 没填写!" && return 1
    [[ -z "$koolclash_cfddns_apikey" ]]  && echo_date "apikey 没填写!" && return 1
    [[ -z "$koolclash_cfddns_domain" ]]  && echo_date "domain 没填写!" && return 1
    [[ -z "$koolclash_cfddns_ttl" ]]  && koolclash_cfddns_ttl="120"
    [[ -z "$koolclash_cfddns_ip" ]]  && koolclash_cfddns_cmd_ip='curl https://httpbin.org/ip 2>/dev/null |grep origin|cut -d\" -f4' && dbus set koolclash_cfddns_ip=$(echo "$koolclash_cfddns_cmd_ip"|base64)
    [[ -z "$koolclash_cfddns_ip" ]]  && echo_date "可能网络链接有问题，暂时无法访问外网,稍后再试!" && return 1
    # 支持多个域名更新
    koolclash_cfddns_dec_domain="$(echo $koolclash_cfddns_domain|base64 -d -w0)"
    koolclash_cfddns_cmd_ip="$(echo $koolclash_cfddns_ip|base64 -d -w0)"
    for current_domain in `echo $koolclash_cfddns_dec_domain | sed 's/[,，]/ /g'`
    do
        echo "当前域名: $current_domain"
        koolclash_cfddns_zone=`echo $current_domain| cut -d. -f2,3`
        koolclash_cfddns_zid=$(curl -X GET "https://api.cloudflare.com/client/v4/zones?name=$koolclash_cfddns_zone" -H "X-Auth-Email: $koolclash_cfddns_email" -H "X-Auth-Key: $koolclash_cfddns_apikey" -H "Content-Type: application/json" | jq -r '.result[0].id')
        koolclash_cfddns_recid=$(curl -X GET "https://api.cloudflare.com/client/v4/zones/$koolclash_cfddns_zid/dns_records?name=$current_domain" -H "X-Auth-Email: $koolclash_cfddns_email" -H "X-Auth-Key: $koolclash_cfddns_apikey" -H "Content-Type: application/json" | jq -r '.result[0].id')
        dbus set koolclash_cfddns_ttl=$koolclash_cfddns_ttl
        real_ip=`echo ${koolclash_cfddns_cmd_ip}|sh 2>/dev/null`
        if [ "$?" != "0" -o "$real_ip" = "" ] ; then
            echo_date "获取IP地址失败! 执行命令:[$koolclash_cfddns_cmd_ip], 提取结果:[$real_ip]"
            return 1
        fi
        dbus set koolclash_cfddns_realip=$real_ip
        update=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$koolclash_cfddns_zid/dns_records/$koolclash_cfddns_recid" -H "X-Auth-Email: $koolclash_cfddns_email" -H "X-Auth-Key: $koolclash_cfddns_apikey" -H "Content-Type: application/json" --data "{\"id\":\"$koolclash_cfddns_zid\",\"type\":\"A\",\"name\":\"$current_domain\",\"content\":\"$real_ip\"}")
        res=`echo $update| jq -r .success`
        if [[ "$res" != "true" ]]; then
            echo_date "更新结果失败!"
            echo "失败详细信息:"
            echo "$update| jq ."
        else
            echo_date "更新DDNS成功!"
            # 添加cron调度
            ttl=`expr $koolclash_cfddns_ttl / 60`
            if [ "$ttl" -lt "2" -o "$ttl" -ge "1440" ] ; then
                ttl="2"
            fi
            cron_file="/etc/crontabs/root"
            if grep start_cfddns $cron_file >/dev/null ; then 
                echo_date "已添加过Cloudflare的DDNS调度"
            else
                cron_job="*/${ttl} * * * * ${main_script} start_cfddns >/dev/null 2>&1"
                echo_date "调度配置: [${cron_job}]"
                echo "$cron_job" >> $cron_file
                if grep start_cfddns $cron_file >/dev/null ; then 
                    echo_date "添加Cloudflare的DDNS调度结果: 成功!"
                else
                    echo_date "添加Cloudflare的DDNS调度结果: 失败!"
                    [[ -d "$(dirname $cron_file)" ]] || ( echo_date "cron路径[$cron_file]目录不存在!" && exit 0)
                    echo_date "可能是添加的命令格式错误了:[$cron_job]"
                    exit 0
                fi
            fi
            koolclash_cfddns_lastmsg="`date +'%Y/%m/%d %H:%M:%S'`"
            dbus set koolclash_cfddns_lastmsg=$koolclash_cfddns_lastmsg
        fi
        echo_date "$koolclash_cfddns_lastmsg"
    done
}

# 保存DDNS配置
save_cfddns() {
    export koolclash_cfddns_enable="$1"
    export koolclash_cfddns_email="$2"
    export koolclash_cfddns_apikey="$3"
    export koolclash_cfddns_dec_domain="$(echo $4 | base64 -d -w0)"
    export koolclash_cfddns_ttl="$5"
    export koolclash_cfddns_cmd_ip="$(echo $6| base64 -d -w0)"

    dbus set koolclash_cfddns_enable=$koolclash_cfddns_enable
    dbus set koolclash_cfddns_email=$koolclash_cfddns_email
    dbus set koolclash_cfddns_apikey=$koolclash_cfddns_apikey
    dbus set koolclash_cfddns_domain="$4"
    dbus set koolclash_cfddns_ttl=$koolclash_cfddns_ttl
    dbus set koolclash_cfddns_ip="$6"
    cron_file="/etc/crontabs/root"
    if [ "$koolclash_cfddns_enable" != "on" ] ; then
        echo_date "正在关闭 Cloudflare DDNS功能:"
        sed -i '/start_cfddns/d' $cron_file
        echo_date "已经关闭 Cloudflare DDNS功能了."
    else
        echo_date "正在启用 Cloudflare DDNS功能:"
        # 添加cron调度
        ttl=`expr $koolclash_cfddns_ttl / 60`
        if [ "$ttl" -lt "2" -o "$ttl" -ge "1440" ] ; then
            ttl="2"
        fi
        if grep start_cfddns $cron_file >/dev/null ; then 
            echo_date "已添加过Cloudflare的DDNS调度"
        else
            cron_job="*/${ttl} * * * * ${main_script} start_cfddns >/dev/null 2>&1"
            echo_date "调度配置: [${cron_job}]"
            echo "$cron_job" >> $cron_file
            if grep start_cfddns $cron_file >/dev/null ; then 
                echo_date "添加Cloudflare的DDNS调度结果: 成功!"
            else
                echo_date "添加Cloudflare的DDNS调度结果: 失败!"
                [[ -d "$(dirname $cron_file)" ]] || ( echo_date "cron路径[$cron_file]目录不存在!" && http_response "error_cron_dir" )
                echo_date "可能是添加的命令格式错误了:[$cron_job]"
                http_response "error_add_cron"
                exit 0
            fi
        fi
        echo_date "启用 Cloudflare DDNS 成功!"
    fi
    http_response "ok"
}


# 切换Clash工作模式
switch_clash_mode() {
    # 根据模式
    work_mode="$1"
    if [ "$work_mode" != "$koolclash_work_mode" ] ; then
        # 模式变更(需要重启clash)
        if [ "$work_mode" == "whitelist" ] ; then
            yq_expr='select(fi==1).rules as $plist | select(fi==0)|.rules = $plist'
            yq ea -iP "$yq_expr" $config_file $rule_whitelist
        else
            work_mode="blacklist"
            yq_expr='select(fi==1).rules as $plist | select(fi==0)|.rules = $plist'
            yq ea -iP "$yq_expr" $config_file $rule_blacklist
        fi
        dbus set koolclash_work_mode="$work_mode"
        echo_date "完成模式规则切换,手工重启生效."
    else
        # 模式没有变化
        echo_date "名单模式没有变化，没有操作!"
    fi
    http_response "ok"
}


# 查看Clash状态信息
koolclash_status() {
    pid_clash=$(pidof clash)
    pid_watchdog="$(pidof koolclash_watchdog.sh)"
    [[ "$pid_watchdog" != "" ]] || pid_watchdog="$(ps | grep koolclash_watchdog.sh|grep -v grep| awk '{print $1}')"
    date=$(echo_date)

    if [ ! -f $config_file ]; then
        host=''
        secret=''
    else
        host=$(yq e '.external-controller' $config_file)
        secret=$(yq e '.secret' $config_file)
    fi

    if [ ! -f $config_file ]; then
        # 没有找到 Clash 配置文件，不显示 DNS 配置输入，dnsmode 为 0
        dbus set koolclash_dnsmode=0
        dnsmode=0
    elif [ $koolclash_dnsmode = 2 ]; then
        # Clash 配置文件存在且 DNS 配置合法，但是用户选择了自定义 DNS 配置，显示 DNS 配置输入，dnsmode 为 2
        dnsmode=2
    elif [ $(yq e '.dns.enable' $origin_file) == 'true' ] && [ $(yq e '.dns.enhanced-mode' $origin_file ) == 'fake-ip' ]; then
        # Clash 配置文件存在且 DNS 配置合法，不显示 DNS 配置输入，dnsmode 为 1
        dbus set koolclash_dnsmode=1
        dnsmode=1
    elif [ ! -f $dns_file ]; then
        dbus set koolclash_dnsmode=3
        # Clash 配置文件存在但 DNS 配置不存在或者不合法，并且没有提交独立 DNS 配置，显示 DNS 配置输入，dnsmode 为 3
        dnsmode=3
    else
        dbus set koolclash_dnsmode=4
        # Clash 配置文件存在但 DNS 配置不存在或者不合法，但是已经提交独立 DNS 配置，显示 DNS 配置输入，dnsmode 为 4
        dnsmode=4
    fi

    if [ -n "$pid_clash" ]; then
        text1="<span style='color: green'>$date Clash 进程运行正常！(PID: $pid_clash)</span>"
    else
        text1="<span style='color: red'>$date Clash 进程未在运行！</span>"
    fi

    if [ -n "$pid_watchdog" ]; then
        text2="<span style='color: green'>$date Clash 看门狗运行正常！(PID: $pid_watchdog)</span>"
    else
        text2="<span style='color: orange'>$date Clash 看门狗未在运行！</span>"
    fi

    touch $dns_file

    fallbackdns=$(cat $dns_file | base64 | xargs)

    http_response "$text1@$text2@$dnsmode@$host@$secret@$lan_ip@$fallbackdns"

}


# 获取调试信息
koolclash_debug_info() {

    koolshare_version=$(cat /etc/banner | grep Openwrt)
    clash_version=$($KSROOT/bin/clash -v)
    fallbackdns=$(cat $dns_file | base64 -w0)

    if [ ! -f "$config_file" ]; then
        clash_allow_lan=''
        clash_ext_controller=''
        clash_redir=''
        clash_dns_enable=''
        clash_dns_ipv6=''
        clash_dns_mode=''
        clash_dns_listen=''
    else
        clash_allow_lan=$(yq e '.allow-lan' $config_file )
        clash_ext_controller=$(yq e '.external-controller' $config_file)
        clash_redir=$(yq e '.redir-port' $config_file)
        clash_dns_enable=$(yq e '.dns.enable' $config_file)
        clash_dns_ipv6=$(yq e '.dns.ipv6' $config_file)
        clash_dns_mode=$(yq e '.dns.enhanced-mode' $config_file)
        clash_dns_listen=$(yq e '.dns.listen' $config_file)
    fi

    iptables_mangle=$(iptables -nvL PREROUTING -t mangle | sed 1,2d | grep 'clash' | base64 | base64 | xargs)
    iptables_nat=$(iptables -nvL PREROUTING -t nat | sed 1,2d | grep 'clash' | base64 | base64 | xargs)
    iptables_mangle_clash=$(iptables -nvL koolclash -t mangle | sed 1,2d | base64 | base64 | xargs)
    iptables_nat_clash=$(iptables -nvL koolclash -t nat | sed 1,2d | base64 | base64 | xargs)
    iptables_mangle_clash_dns=$(iptables -nvL koolclash_dns -t mangle | sed 1,2d | base64 | base64 | xargs)
    iptables_nat_clash_dns=$(iptables -nvL koolclash_dns -t nat | sed 1,2d | base64 | base64 | xargs)

    white_ip=$(ipset list koolclash_white | base64 | xargs)

    chromecast_nu=$(iptables -t nat -L PREROUTING -v -n --line-numbers | grep "dpt:53" | base64 | xargs)

    clash_process=$(ps | grep clash | grep -v grep | base64 | xargs)

    clash_config_dir=$(ls -lh /koolshare/koolclash/config | base64 | xargs)

    http_response "{ \\\"lan_ip\\\": \\\"${lan_ip}\\\", \\\"koolshare_version\\\": \\\"$koolshare_version\\\", \\\"clash_allow_lan\\\": \\\"$clash_allow_lan\\\", \\\"clash_ext_controller\\\": \\\"$clash_ext_controller\\\", \\\"clash_dns_enable\\\": \\\"$clash_dns_enable\\\", \\\"clash_dns_ipv6\\\": \\\"$clash_dns_ipv6\\\", \\\"clash_dns_mode\\\": \\\"$clash_dns_mode\\\", \\\"clash_dns_listen\\\": \\\"$clash_dns_listen\\\", \\\"fallbackdns\\\": \\\"$fallbackdns\\\", \\\"iptables_mangle\\\": \\\"$iptables_mangle\\\", \\\"iptables_nat\\\": \\\"$iptables_nat\\\", \\\"iptables_mangle_clash\\\": \\\"$iptables_mangle_clash\\\", \\\"iptables_nat_clash\\\": \\\"$iptables_nat_clash\\\", \\\"iptables_mangle_clash_dns\\\": \\\"$iptables_mangle_clash_dns\\\", \\\"iptables_nat_clash_dns\\\": \\\"$iptables_nat_clash_dns\\\", \\\"clash_redir\\\": \\\"$clash_redir\\\", \\\"firewall_white_ip\\\": \\\"$white_ip\\\", \\\"chromecast_nu\\\": \\\"$chromecast_nu\\\", \\\"clash_process\\\": \\\"$clash_process\\\", \\\"clash_config_dir\\\": \\\"$clash_config_dir\\\", \\\"clash_version\\\": \\\"$clash_version\\\"}"

}
#------ main process 主处理流程 --------
# Web UI callback

do_action="$2"
case "$do_action" in

upload_config_file| sub_delete| koolclash_debug_info| koolclash_status|koolclash_update_mmdb|node_delete_all)
    # 无参数调用模块函数
    $do_action
    ;;
save_cfddns)
    shift 2
    $do_action $@
    ;;
change_external_controller_ip| sub_update|firewall_white_ip_add|node_add|node_delete_one| koolclash_watchdog_enable| switch_clash_mode)
    # 携带参数(参数值加密为Base64格式)模块调用
    $do_action $3
;;
esac

case "$1" in
init)
    # 第一次安装初始化 配置信息
    # 生成 config.yaml 启动配置文件
    generate_config_file

    # 检验 config.yaml 配置文件有效性
    check_config_file "$1"

    # 第一次初始化节点列表
    node_list "$1"
;;
start_cfddns)
    start_cfddns
;;
esac

#---end