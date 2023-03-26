<title>KoolClash - Clash for Koolshare OpenWrt/LEDE</title>
<content>
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="/res/koolclash_base64.js"></script>
    <script type="text/javascript" src="/js/tomato.js"></script>
    <script type="text/javascript" src="/js/advancedtomato.js"></script>
    <script type="text/javascript" src="/layer/layer.js"></script>
    <style type="text/css">
        .box,
        #clash_tabs {
            min-width: 720px;
        }

        .koolclash-divider {
            content: '|';
            margin: 0 5px;
        }

        .koolclash-btn-container {
            padding: 4px;
            padding-left: 8px;
        }

        hr {
            opacity: 1;
            border: 1px solid #ccc;
            margin: 1rem 0;
        }

        #koolclash-ip .ip-title {
            font-weight: bold;
            color: #444;
        }

        #koolclash-ip .sk-text-success {
            color: #32b643
        }

        #koolclash-ip .sk-text-error {
            color: #e85600
        }

        #koolclash-ip p {
            margin: 2px 0;
        }

        #koolclash-btn-upload {
            margin-bottom: 8px;
            margin-left: 4px;
        }

        #koolclash-btn-submit-watchdog {
            margin-bottom: 5px;
            margin-left: 8px;
        }

        #koolclash-dns-msg {
            font-size: 85%;
            margin-top: 8px
        }

        #koolclash-config-dns {
            margin-top: 16px;
        }

        #_koolclash_config_suburl {
            width: 61.8%;
        }

        #koolclash-version-msg {
            font-size: 14px;
        }

        fieldset .help-block {
            margin: 0;
        }

        label {
            cursor: default;
        }

        label.koolclash-nav-label {
            padding: 0;
            cursor: pointer;
        }

        .koolclash-nav-radio {
            display: none;
        }

        .koolclash-nav-tab {
            display: block;
            padding: 0 15px;
            height: 40px;
            font-weight: normal;
            line-height: 40px;
            text-shadow: 0 1px 0 rgba(255, 255, 255, 0.2);
            transition: all 100ms ease;
            -webkit-transition: all 100ms ease;
            text-decoration: none;
            outline: 0;
        }

        .koolclash-nav-tab:hover {
            z-index: 999;
            color: #777777;
            background: rgba(0, 0, 0, 0.05);
            border-bottom: 2px solid rgba(0, 0, 0, 0.05);
            text-decoration: none;
        }


        #koolclash-nav-overview:checked~.nav-tabs .koolclash-nav-overview>.koolclash-nav-tab,
        #koolclash-nav-config:checked~.nav-tabs .koolclash-nav-config>.koolclash-nav-tab,
        #koolclash-nav-node:checked~.nav-tabs .koolclash-nav-node>.koolclash-nav-tab,
        #koolclash-nav-firewall:checked~.nav-tabs .koolclash-nav-firewall>.koolclash-nav-tab,
        #koolclash-nav-additional:checked~.nav-tabs .koolclash-nav-additional>.koolclash-nav-tab,
        #koolclash-nav-log:checked~.nav-tabs .koolclash-nav-log>.koolclash-nav-tab,
        #koolclash-nav-debug:checked~.nav-tabs .koolclash-nav-debug>.koolclash-nav-tab {
            border-bottom: 2px solid #f36c21;
            background: transparent;
            z-index: 999;
            color: #777777;
        }

        .tab-content>* {
            display: none;
        }

        #koolclash-nav-overview:checked~.tab-content>#koolclash-content-overview,
        #koolclash-nav-config:checked~.tab-content>#koolclash-content-config,
        #koolclash-nav-node:checked~.tab-content>#koolclash-content-node,
        #koolclash-nav-firewall:checked~.tab-content>#koolclash-content-firewall,
        #koolclash-nav-additional:checked~.tab-content>#koolclash-content-additional,
        #koolclash-nav-log:checked~.tab-content>#koolclash-content-log,
        #koolclash-nav-debug:checked~.tab-content>#koolclash-content-debug {

            display: block;
        }

        #_koolclash_log {
            max-width: 100%;
            min-width: 100%;
            margin: 0;
            min-height: 300px;
            max-height: 500px;
            font-family: Consolas, "Panic Sans", "DejaVu Sans Mono", Monaco, "Bitstream Vera Sans Mono", 'Andale Mono', Menlo, monospace !important;
        }

        #_koolclash_debug_info {
            max-width: 100%;
            min-width: 100%;
            margin: 0;
            min-height: 600px;
            font-family: Consolas, "Panic Sans", "DejaVu Sans Mono", Monaco, "Bitstream Vera Sans Mono", 'Andale Mono', Menlo, monospace !important;
        }

        table.line-table tr:nth-child(even) {
            background: rgba(0, 0, 0, 0.04)
        }

        table.line-table tr:hover {
            background: #D7D7D7
        }

        table.line-table tr:hover .progress {
            background: #D7D7D7
        }

        /*#koolclash-acl-default-panel {
            margin-top: 16px;
        }*/

    </style>
    <script>
        var softcenter = 0;
    </script>

    <div class="box">
        <div class="heading">
            <a style="padding-left: 0; color: #0099FF; font-size: 20px;" href="https://koolclash.js.org" target="_blank">KoolClash - Clash for Koolshare OpenWrt/LEDE</a>
            <a href="#/soft-center.asp" class="btn" style="float: right; margin-right: 5px; border-radius:3px; margin-top: 0px;">返回</a>
            <br>
            <span id="koolclash-version-msg"></span>
            <!--<a href="https://github.com/koolshare/ledesoft/blob/master/v2ray/Changelog.txt" target="_blank"
                class="btn btn-primary" style="float:right;border-radius:3px;margin-right:5px;margin-top:0px;">更新日志</a>-->
            <!--<button type="button" id="updateBtn" onclick="check_update()" class="btn btn-primary" style="float:right;border-radius:3px;margin-right:5px;margin-top:0px;">检查更新 <i class="icon-upgrade"></i></button>-->
        </div>
        <div class="content">
            <div class="col" style="line-height: 30px;">
                <p style="margin-top: 4px">Clash 是一个基于规则的代理程序，兼容 Shadowsocks、ShadowsocksR、Vmess 及Trajan等协议，拥有像 Surge 一样强大的代理规则。</p>
                <p>KoolClash 是 Clash Premium版本 在 <b style="color: red;">X86_64架构的Koolshare OpenWrt</b>  上的客户端。</p>

                <p style="margin-top: 12px">
                    <a href="https://github.com/Dreamacro/clash">Clash on GitHub</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <a href="https://koolclash.js.org" target="_blank">KoolClash 使用文档</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <a href="https://github.com/SukkaW/Koolshare-Clash/releases" target="_blank">KoolClash 更新日志</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <a href="https://github.com/SukkaW/Koolshare-Clash" target="_blank">KoolClash on GitHub(原作者:SukkaW)</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <a href="https://github.com/learnhard-cn/Koolshare-Clash-openwrt-amd64" target="_blank">KoolClash on GitHub(当前版本)</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <a href="https://t.me/share_proxy_001" target="_blank">Telrgram电报群</a>
                </p>
            </div>
        </div>
    </div>

    <!-- Basic Elements used for tab -->
    <input class="koolclash-nav-radio" id="koolclash-nav-overview" type="radio" name="nav-tab" checked>
    <input class="koolclash-nav-radio" id="koolclash-nav-config" type="radio" name="nav-tab">
    <input class="koolclash-nav-radio" id="koolclash-nav-node" type="radio" name="nav-tab">
    <input class="koolclash-nav-radio" id="koolclash-nav-firewall" type="radio" name="nav-tab">
    <input class="koolclash-nav-radio" id="koolclash-nav-additional" type="radio" name="nav-tab">
    <input class="koolclash-nav-radio" id="koolclash-nav-log" type="radio" name="nav-tab">
    <input class="koolclash-nav-radio" id="koolclash-nav-debug" type="radio" name="nav-tab">

    <!-- Msg Elements -->
    <div id="msg_success" class="alert alert-success icon" style="display: none;"></div>
    <div id="msg_error" class="alert alert-error icon" style="display: none;"></div>
    <div id="msg_warning" class="alert alert-warning icon" style="display: none;"></div>

    <ul class="nav nav-tabs">
        <li>
            <label class="koolclash-nav-overview koolclash-nav-label" for="koolclash-nav-overview">
                <div class="koolclash-nav-tab">
                    <i class="icon-info"></i>
                    运行状态
                </div>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-config koolclash-nav-label" for="koolclash-nav-config">
                <div class="koolclash-nav-tab">
                    <i class="icon-system"></i>
                    配置文件
                </div>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-node koolclash-nav-label" for="koolclash-nav-node">
                <div class="koolclash-nav-tab">
                    <i class="icon-system"></i>
                    DIY节点配置
                </div>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-firewall koolclash-nav-label" for="koolclash-nav-firewall">
                <div class="koolclash-nav-tab">
                    <i class="icon-lock"></i>
                    访问控制
                </div>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-additional koolclash-nav-label" for="koolclash-nav-additional">
                <div class="koolclash-nav-tab">
                    <i class="icon-wake"></i>
                    附加功能
                </div>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-log koolclash-nav-label" for="koolclash-nav-log">
                <div class="koolclash-nav-tab">
                    <i class="icon-hourglass"></i>
                    操作日志
                </div>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-debug koolclash-nav-label" for="koolclash-nav-debug">
                <div class="koolclash-nav-tab">
                    <i class="icon-warning"></i>
                    调试工具
                </div>
            </label>
        </li>
    </ul>
    <div class="tab-content">
        <div id="koolclash-content-overview">
            <div class="box">
                <div class="heading">KoolClash 管理</div>

                <div class="content">
                    <!-- ### KoolClash 运行状态 ### -->
                    <div id="koolclash-field"></div>
                    <div class="koolclash-btn-container">
                        <button type="button" id="koolclash-btn-start-clash" onclick="KoolClash.restart()" class="btn btn-success">启动/重启 Clash</button>
                        <button type="button" id="koolclash-btn-stop-clash" onclick="KoolClash.stop()" class="btn btn-danger">停止 Clash</button>
                    </div>
                </div>
            </div>

            <div class="box">
                <div class="heading" style="padding-bottom: 4px">Clash 外部控制</div>
                <div class="content">
                    <!-- ### KoolClash 面板 ### -->
                    <div id="koolclash-dashboard-info"></div>

                    <div class="koolclash-btn-container">
                        <a href="#" target="_blank" id="btn-open-clash-dashboard" class="btn btn-primary">访问 Clash 面板</a>
                        <button type="button" id="koolclash-btn-submit-control" onclick="KoolClash.submitExternalControl();" class="btn">提交外部控制配置</button>
                        <p style="margin-top: 8px">只有在 Clash 正在运行的时候才可以访问 Clash 面板</p>
                    </div>
                </div>
            </div>
        </div>
        <div id="koolclash-content-config">
            <div class="box">
                <div class="heading">KoolClash 配置文件</div>

                <div class="content">
                    <!-- ### KoolClash 运行配置设置 ### -->
                    <div id="koolclash-config"></div>
                    <div class="koolclash-btn-container">
                        <button type="button" id="koolclash-btn-update-sub" onclick="KoolClash.updateRemoteConfig();" class="btn">更新 Clash 托管配置</button>
                        <button type="button" id="koolclash-btn-del-suburl" onclick="KoolClash.deleteSuburl();" class="btn btn-danger">删除托管 URL（保留 Clash 配置）</button>
                    </div>
                </div>
            </div>
            <div class="box">
                <div class="heading">自定义 DNS 配置</div>
                <div class="content">
                    <!-- ### KoolClash DNS 设置 ### -->
                    <div id="koolclash-config-dns"></div>
                    <div class="koolclash-btn-container">
                        <button type="button" id="koolclash-btn-save-dns-config" onclick="KoolClash.submitDNSConfig();" class="btn btn-primary">提交 DNS 配置</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="koolclash-content-node">
            <div class="box">
                <div class="heading">KoolClash添加DIY节点管理</div>

                <div class="content">
                    <p>支持两类格式: 1. <b style="color: red;">http(s)://</b>开头节点订阅源 和 单个代理节点,格式如<b style="color: red;">ss://,ssr://,vmess://</b>等代理节点格式.(有问题TG留言!)</p>
                    <div id="koolclash-node"></div>
                    <div id="koolclash-node-msg"></div>
                </div>
            </div>
        </div>
        <div id="koolclash-content-firewall">
            <div class="box">
                <div class="heading" style="margin-top: -15px;"></div>
                <div class="content">
                    <div id="koolclash-firewall-ipset"></div>
                    <div class="koolclash-btn-container">
                        <button type="button" id="koolclash-btn-submit-white-ip" onclick="KoolClash.acl.submitWhiteIP();" class="btn btn-primary">提交</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="koolclash-content-log">
            <div class="box">
                <div class="heading">KoolClash 操作日志</div>
                <div class="content">
                    <textarea class="as-script" name="koolclash_log" id="_koolclash_log" readonly wrap="off" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                </div>
            </div>
        </div>
        <div id="koolclash-content-debug">
            <div class="box">
                <div class="heading">KoolClash 调试工具</div>
                <div class="content">
                    <p>KoolClash 的调试工具，可以输出 KoolClash 的相关信息、参数。在反馈 KoolClash 的使用问题时附上相关信息可以帮助开发者更好的定位问题。</p>

                    <button type="button" id="koolclash-btn-debug" onclick="KoolClash.debugInfo();" class="btn btn-danger" style="margin-top: 6px; margin-bottom: 12px">获取 KoolClash 调试信息</button>

                    <textarea class="as-script" name="koolclash_debug_info" id="_koolclash_debug_info" readonly wrap="off" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                </div>
            </div>
        </div>
        <div id="koolclash-content-additional">
            <div class="box">
                <div class="heading">Clash 看门狗</div>
                <div class="content">
                    <p>KoolClash 实现的 Clash 进程守护工具，每 20 秒检查一次 Clash 进程是否存在，如果 Clash 进程丢失则会自动重新拉起。</p>
                    <p style="color:red; margin-top: 8px">Clash 已经支持保存节点选择状态啦!重启后会使用上次选择节点！</p>
                    <div id="koolclash-watchdog-panel" style="margin-top: 16px"></div>
                </div>
            </div>
            <div class="box">
                <div class="heading">GeoIP 数据库</div>
                <div class="content">
                    <p>Clash 使用由 <a href="https://www.maxmind.com/" target="_blank">MaxMind</a> 提供的 <a href="https://dev.maxmind.com/geoip/geoip2/geolite2/" target="_blank">GeoLite2</a> IP 数据库解析 GeoIP 规则</p>
                    <div id="koolclash-ipdb-panel" style="margin-top: 8px"></div>
                </div>
            </div>
            <div class="box">
                <div class="heading">CloudFlare动态DNS更新管理</div>
                <div class="content">
                    <p>使用CloudFlare的DDNS服务可以帮助您远程管理家庭内网主机:<b style="color: red;">远程访问内网的HTTP、SSH等服务.(建议设置复杂密码/以免被暴力破解)</b></p>
                    <div id="koolclash-cfddns-panel" style="margin-top: 8px"></div>
                </div>
            </div>
        </div>
    </div>

    <script>
        
        var Msg = {
            show: (type, text) => {
                E(`msg_${type}`).innerHTML = text;
                $(`#msg_${type}`).show();
            },
            hide: (type) => {
                $(`#msg_${type}`).hide();
                E(`msg_${type}`).innerHTML = '';
            }
        };

        var KoolClash = {
            // KoolClash.renderUI()
            // 创建 KoolClash 界面
            renderUI: () => {
                var inputWidth = `min-width: 220px; max-width: 220px`;
                $('#koolclash-field').forms([
                    {
                        title: '<b>Clash 进程状态</b>',
                        text: '<span id="koolclash_status" name="koolclash_status" color="#1bbf35">正在获取 Clash 进程状态...</span>'
                    },
                    {
                        title: '<b>Clash 看门狗进程状态</b>',
                        text: '<span id="koolclash_watchdog_status" name="koolclash_watchdog_status" color="#1bbf35">正在获取 Clash 看门狗进程状态...</span>'
                    },
                    {
                        title: '黑白名单切换(重启后生效)',
                        name: 'koolclash-select-mode',
                        type: 'select',
                        options: [ 
                            ['whitelist', '白名单(匹配规则代理)'],
                            ['blacklist', '黑名单(匹配规则直连)']
                        ],
                        value: window.dbus.koolclash_work_mode || 'blacklist',
                        suffix: '<button type="button" id="koolclash-btn-switch-mode" onclick="KoolClash.submitClashSwitchMode();" class="btn btn-primary">切换模式</button>',
                    },
                ]);
                $('#koolclash-dashboard-info').forms([
                    {
                        title: '<b>Host</b>',
                        name: 'koolclash_dashboard_host',
                        type: 'text',
                        value: ''
                    },
                    {
                        title: '<b>端口</b>',
                        text: '6170'
                    },
                    {
                        title: '<b>密钥</b>',
                        text: window.dbus.koolclash_api_secret || 'Clash 配置文件中的 secret'
                    },
                ]);
                $('#koolclash-config').forms([
                    {
                        title: '<b>Clash 配置上传</b>',
                        suffix: '<input type="file" id="koolclash-file-config" size="50"><button id="koolclash-btn-upload" type="button" onclick="KoolClash.submitClashConfig();" class="btn btn-primary">上传配置文件</button>'
                    },
                    {
                        title: '<b>Clash 托管配置 URL</b><br><small>请注意！务必谨慎使用该功能！</small>',
                        name: 'koolclash_config_suburl',
                        type: 'text',
                        value: window.dbus.koolclash_suburl || '',
                        placeholder: 'https://api.example.com/clash'
                    },
                ]);
                $('#koolclash-node').forms([
                    {
                        title: '<b>输入节点URI链接</b>',
                        name: 'koolclash_node_uri',
                        type: 'text',
                        style: 'width: 60%; height: 30px;',
                        placeholder: 'ss://xxxxxxxx',
                        suffix: '<button id="koolclash-btn-addnode" type="button" onclick="KoolClash.submitClashAddNode();" class="btn btn-primary">添加DIY节点</button>'
                    },
                    {
                        title: '已经添加的DIY节点列表',
                        name: 'koolclash-select-nodelist',
                        type: 'select',
                        options: [ ],
                        suffix: '<button type="button" id="koolclash-btn-submit-nodelist" onclick="KoolClash.submitClashDeleteNode();" class="btn btn-primary">删除节点</button>&nbsp;&nbsp;<button type="button" id="koolclash-btn-submit-delete-all" onclick="KoolClash.submitClashDeleteAll();" class="btn btn-primary">删除所有节点</button>',
                    },
                ]);
                $('#koolclash-config-dns').forms([
                    {
                        title: '<b>DNS 配置开关</b>',
                        name: 'koolclash-dns-config-switch',
                        type: 'checkbox'
                    },
                    {
                        title: '&nbsp;',
                        text: '<p id="koolclash-dns-msg" style="margin-top: 10px; margin-bottom: 6px"></p>'
                    },
                    {
                        title: '',
                        name: 'koolclash-config-dns',
                        type: 'textarea',
                        value: '正在加载存储的 Clash DNS Config 配置...',
                        style: 'width: 100%; height: 200px;'
                    },
                ]);
                $('#koolclash-firewall-ipset').forms([
                    {
                        title: '<b>IP/CIDR 白名单</b><br><br><p style="color: #999">不通过 Clash 的 IP/CIDR 外网地址，一行一个，例如：<br>119.29.29.29<br>210.2.4.0/24</p>',
                        name: 'koolclash_firewall_white_ipset',
                        type: 'textarea',
                        value: Base64.decode(window.dbus.koolclash_firewall_whiteip_base64 || '') || '',
                        style: 'width: 80%; height: 150px;'
                    },
                ]);
                $('#koolclash-watchdog-panel').forms([
                    {
                        title: 'Clash 看门狗开关',
                        name: 'koolclash-select-watchdog',
                        type: 'select',
                        options: [
                            ['0', '禁用'],
                            ['1', '开启']
                        ],
                        suffix: '<button type="button" id="koolclash-btn-submit-watchdog" onclick="KoolClash.submitWatchdog();" class="btn btn-primary">提交</button>',
                        value: window.dbus.koolclash_watchdog_enable || '0',
                    },
                ]);
                $('#koolclash-ipdb-panel').forms([
                    {
                        title: '<b>当前 IP 数据库版本</b>',
                        name: 'koolclash-ipdb-version',
                        text: `${window.dbus.koolclash_ipdb_version || '没有获取到版本信息'}<button type="button" id="koolclash-btn-update-ipdb" onclick="KoolClash.updateIPDB()" class="btn btn-success" style="margin-left: 16px; margin-top: -6px; ">更新 IP 数据库</button>`,
                    },
                ]);
                $('#koolclash-cfddns-panel').forms([
                    {
                        title: 'CloudFlare DDNS服务管理',
                        name: 'koolclash_cfddns_enable',
                        type: 'select',
                        options: [
                            ['off', '禁用'],
                            ['on', '开启']
                        ],
                        suffix: '<button type="button" id="koolclash-btn-submit-cfddns" onclick="KoolClash.submitCFDDNS();" class="btn btn-primary">提交</button>',
                        value: window.dbus.koolclash_cfddns_enable || 'off',
                    }, {
                        title: '<b>CF帐号Email:</b>',
                        name: 'koolclash_cfddns_email',
                        type: 'text',
                        value: window.dbus.koolclash_cfddns_email || '',
                    }, {
                        title: '<b>CF帐号API-key:</b>',
                        name: 'koolclash_cfddns_apikey',
                        type: 'text',
                        value: window.dbus.koolclash_cfddns_apikey || '',
                    }, {
                        title: '<b>CF帐号domain(逗号分割):</b>',
                        name: 'koolclash_cfddns_domain',
                        type: 'text',
                        value: window.dbus.koolclash_cfddns_domain || '',
                    }, {
                        title: '<b>TTL生命周期</b><b style="color:red">(可不填)<b>:',
                        name: 'koolclash_cfddns_ttl',
                        type: 'text',
                        value: window.dbus.koolclash_cfddns_ttl || 120,
                    }, {
                        title: '<b>获取公网IP命令</b><b style="color:red">(可不填)<b>:',
                        name: 'koolclash_cfddns_ip',
                        type: 'text',
                        value: window.dbus.koolclash_cfddns_ip,
                    }, {
                        title: '<b style="color:red">上次检测公网IP<b>:',
                        name: 'koolclash_cfddns_realip',
                        type: 'text',
                        value: window.dbus.koolclash_cfddns_realip || '',
                        
                    }, {
                        title: '<b style="color:red">上次检测时间<b>:',
                        name: 'koolclash_cfddns_lastmsg',
                        type: 'text',
                        readonly: true,
                        value: window.dbus.koolclash_cfddns_lastmsg || '',
                    }, 
                ]);
                $('.koolclash-nav-log').on('click', KoolClash.getLog);
            },
            // 选择 Tab
            // 注意选择的方式是使用 input 的 ID
            selectTab: (inputId) => {
                for (let i of document.getElementsByClassName('koolclash-nav-radio')) {
                    i.removeAttribute('checked');
                }
                E(inputId).click();
            },
            checkUpdate: () => {
                let installed = '',
                    remote = '';
                // 获取本地版本号
                $.ajax({
                    type: "GET",
                    cache: false,
                    url: "/res/koolclash_.version",
                    success: (resp) => {
                        installed = resp;
                        E('koolclash-version-msg').innerHTML = `当前安装版本&nbsp;:&nbsp;${installed}`;
                        // 获取远端版本号
                        $.ajax({
                            type: "GET",
                            cache: false,
                            url: "https://koolclash.js.org/koolclash_version",
                            success: (resp) => {
                                remote = resp;
                                E('koolclash-version-msg').innerHTML = `当前安装版本&nbsp;:&nbsp;${installed}&nbsp;&nbsp;/&nbsp;&nbsp;最新发布版本&nbsp;:&nbsp;${remote}`;

                                if (installed !== remote) {
                                    E('koolclash-version-msg').innerHTML = `当前安装版本&nbsp;:&nbsp;${installed}&nbsp;&nbsp;|&nbsp;&nbsp;最新发布版本&nbsp;:&nbsp;${remote}<br>发现「当前安装版本」与「最新发布版本」版本号不同，可能是 KoolClash 有新版本发布，请前往 <a href="https://github.com/SukkaW/Koolshare-Clash/releases" target="_blank" style="padding: 0; color: navy">GitHub Release</a> 查看更新日志`;
                                }
                            }
                        });
                    },
                    error: () => {
                        E('koolclash-version-msg').innerHTML = `检测版本失败！`
                    }
                });


                E('koolclash-version-msg').innerHTML = `当前安装版本&nbsp;:&nbsp;<span id="koolclash-version-installed"></span>&nbsp;&nbsp;|&nbsp;&nbsp;最新发布版本&nbsp;:&nbsp;<span id="koolclash-version-remote"></span>`;
            },
            defaultDNSConfig: Base64.decode("IyDmsqHmnInmib7liLDkv53lrZjnmoQgQ2xhc2gg6Ieq5a6a5LmJIEROUyDphY3nva7vvIzmjqjojZDkvb/nlKjku6XkuIvnmoTphY3nva4KZG5zOgogIGVuYWJsZTogdHJ1ZQogIGlwdjY6IGZhbHNlCiAgbGlzdGVuOiAwLjAuMC4wOjIzNDUzCiAgZW5oYW5jZWQtbW9kZTogcmVkaXItaG9zdCAjIHJlZGlyLWhvc3Qgb3IgZmFrZS1pcAogIGZha2UtaXAtcmFuZ2U6IDE5OC4xOC4wLjEvMTYgIyBGYWtlIElQIGFkZHJlc3NlcyBwb29sIENJRFIKICB1c2UtaG9zdHM6IGZhbHNlICMgbG9va3VwIGhvc3RzIGFuZCByZXR1cm4gSVAgcmVjb3JkCiAgbmFtZXNlcnZlcjoKICAgIC0gMTE0LjExNC4xMTQuMTE0CiAgIyDmj5DkvpsgZmFsbGJhY2sg5pe277yM5aaC5p6cR0VPSVDpnZ4gQ04g5Lit5Zu95pe25L2/55SoIGZhbGxiYWNrIOino+aekAogIGZhbGxiYWNrOgogICAgLSA4LjguOC44ICMgR29vZ2xlIEROUyBvdmVyIFRDUAogICAgLSAxLjEuMS4xICMgY2xvdWRmbGFyZSBETlMgb3ZlciBUQ1AKICAgIC0gdGxzOi8vOC44LjguODo4NTMgIyBHb29nbGUgRE5TIG92ZXIgVExTCiAgICAtIHRsczovLzEuMS4xLjE6ODUzICMgY2xvdWRmbGFyZSBETlMgb3ZlciBUTFMKICAgIC0gaHR0cHM6Ly9kbnMuZ29vZ2xlL2Rucy1xdWVyeSAjIEdvb2dsZSBETlMgb3ZlciBIVFRQUwogICAgLSBodHRwczovL2Nsb3VkZmxhcmUtZG5zLmNvbS9kbnMtcXVlcnkgIyBjbG91ZGZsYXJlIEROUyBvdmVyIEhUVFBTCiAgIyDlvLrliLZETlPop6PmnpDkvb/nlKhgZmFsbGJhY2tg6YWN572uCiAgZmFsbGJhY2stZmlsdGVyOgogICAgIyB0cnVlOiBDTuS9v+eUqG5hbWVzZXJ2ZXLop6PmnpDvvIzpnZ5DTuS9v+eUqGZhbGxiYWNrCiAgICBnZW9pcDogdHJ1ZQogICAgIyBnZW9pcOiuvue9ruS4umZhbHNl5pe25pyJ5pWI77yaIOS4jeWMuemFjWBpcGNpZHJg5Zyw5Z2A5pe25Lya5L2/55SoYG5hbWVzZXJ2ZXJg57uT5p6c77yM5Yy56YWNYGlwY2lkcmDlnLDlnYDml7bkvb/nlKhgZmFsbGJhY2tg57uT5p6c44CCCiAgICBpcGNpZHI6CiAgICAgIC0gMjQwLjAuMC4wLzQKCg=="),
            // getClashStatus
            // 获取 Clash 进程 PID
            getClashStatus: () => {
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_main.sh",
                        "params": ["koolclash_status"],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (softcenter === 1) {
                            return false;
                        }

                        let data = resp.result.split('@'),
                            pid_text = data[0],
                            pid_watchdog_text = data[1],
                            dnsmode = data[2],
                            control_data = data[3],
                            secret = data[4],
                            fallbackdns = data[6];

                        if (fallbackdns === '') {
                            E('_koolclash-config-dns').innerHTML = KoolClash.defaultDNSConfig;
                        } else {
                            E('_koolclash-config-dns').innerHTML = Base64.decode(fallbackdns || '') || KoolClash.defaultDNSConfig;
                        }

                        let control_host = control_data.split(':')[0],
                            control_port = control_data.split(':')[1];

                        control_host = (control_host.length === 0) ? `请先上传 Clash 配置文件！` : control_host;
                        E('koolclash_status').innerHTML = pid_text;
                        E('koolclash_watchdog_status').innerHTML = pid_watchdog_text;
                        E('_koolclash_dashboard_host').value = control_host;
                        E('btn-open-clash-dashboard').href = `http://${control_host}:6170/ui/?hostname=${control_host}&port=6170&secret=route`
                        /*
                         * 0 没有找到 config.yaml
                         * 1 origin.yml DNS 配置合法
                         * 2 origin.yml DNS 配置合法 但是用户想要自定义 DNS
                         * 3 origin.yml DNS 配置不合法而且没有 dns.yml
                         * (4) origin.yml DNS 配置不合法但是有 dns.yml
                         */
                        if (dnsmode === '0') {
                            E('_koolclash-dns-config-switch').checked = false;
                            E('_koolclash-dns-config-switch').setAttribute('disabled', '');
                            $('#koolclash-btn-save-dns-config').hide();
                            $('#_koolclash-config-dns').hide();
                            E('koolclash-dns-msg').innerHTML = `请先上传 Clash 配置文件！`
                        } else if (dnsmode === '1') {
                            E('_koolclash-dns-config-switch').checked = false;
                            $('#koolclash-btn-save-dns-config').hide();
                            $('#_koolclash-config-dns').hide();
                            E('koolclash-dns-msg').innerHTML = `Clash 配置文件存在且 DNS 配置合法。如果想覆盖 Clash 配置文件中的 DNS 配置请勾选上面的单选框`
                        } else if (dnsmode === '2') {
                            E('_koolclash-dns-config-switch').checked = true;
                            $('#koolclash-btn-save-dns-config').show();
                            $('#_koolclash-config-dns').show();
                            E('koolclash-dns-msg').innerHTML = `已经使用下面的 DNS 配置覆盖 Clash 配置文件中的 DNS 配置`
                        } else if (dnsmode === '3') {
                            E('_koolclash-dns-config-switch').checked = true;
                            E('_koolclash-dns-config-switch').setAttribute('disabled', '');
                            $('#koolclash-btn-save-dns-config').show();
                            $('#_koolclash-config-dns').show();
                            E('koolclash-dns-msg').innerHTML = `Clash 配置文件存在，但配置文件中不存在 DNS 配置或配置不合法。请在下面提交 DNS 配置！`
                        } else {
                            E('_koolclash-dns-config-switch').checked = true;
                            E('_koolclash-dns-config-switch').setAttribute('disabled', '');
                            $('#koolclash-btn-save-dns-config').show();
                            $('#_koolclash-config-dns').show();
                            E('koolclash-dns-msg').innerHTML = `Clash 配置文件存在，但原始配置文件中不存在 DNS 配置或配置不合法，已经生效下面的 DNS 配置`
                        }
                    },
                    error: () => {
                        if (softcenter === 1) {
                            return false;
                        }
                        E('koolclash_status').innerHTML = `<span style="color: red">获取 Clash 进程运行状态失败！请刷新页面重试`;
                        E('koolclash_watchdog_status').innerHTML = `<span style="color: red">获取 Clash 看门狗进程运行状态失败！请刷新页面重试`;
                    }
                });
            },
            disableAllButton: () => {
                let btnList = document.getElementsByTagName('button');
                for (let i of btnList) {
                    i.setAttribute('disabled', '');
                }
            },
            enableAllButton: () => {
                let btnList = document.getElementsByTagName('button');
                for (let i of btnList) {
                    i.removeAttribute('disabled');
                }
            },
            submitExternalControl: () => {
                KoolClash.disableAllButton();

                let id = parseInt(Math.random() * 100000000);
                let postData = JSON.stringify({
                    id,
                    "method": "koolclash_main.sh",
                    "params": [ "change_external_controller_ip", `${E('_koolclash_dashboard_host').value}`],
                    "fields": ""
                });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        E('koolclash-btn-submit-control').innerHTML = '外部控制 IP 设置成功(下次重启Clash服务才能生效)！页面将会自动刷新！';
                        setTimeout(() => {
                            window.location.reload();
                        }, 3000)
                    },
                    error: () => {
                        E('koolclash-btn-submit-control').innerHTML = '外部控制 IP 设置失败！';
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            E('koolclash-btn-submit-control').innerHTML = '提交外部控制设置';
                        }, 3000)
                    }
                });
            },
            submitClashConfig: () => {
                KoolClash.disableAllButton();
                E('koolclash-btn-upload').innerHTML = '正在上传 Clash 配置...';

                let formData = new FormData();
                formData.append('clash.config.yaml', $('#koolclash-file-config')[0].files[0]);
                $.ajax({
                    url: '/_upload',
                    type: 'POST',
                    async: true,
                    cache: false,
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: (resp) => {
                        E('koolclash-btn-upload').innerHTML = '正在上传 Clash 配置...';
                        (() => {
                            let id = parseInt(Math.random() * 100000000),
                                postData = JSON.stringify({
                                    id,
                                    "method": "koolclash_main.sh",
                                    "params": ["upload_config_file"],
                                    "fields": ""
                                });

                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "/_api/",
                                data: postData,
                                dataType: "json",
                                success: (resp) => {
                                    if (resp.result === 'notfound') {
                                        E('koolclash-btn-upload').innerHTML = '上传的配置文件找不到了！请重试！';
                                        setTimeout(() => {
                                            KoolClash.enableAllButton();
                                            E('koolclash-btn-upload').innerHTML = '上传配置文件';
                                        }, 3000)
                                    } else if (resp.result === 'nofallbackdns') {
                                        E('koolclash-btn-upload').innerHTML = '在配置文件中没有找到 DNS 设置，请在下面添加 DNS 配置！';
                                        // KoolClash.selectTab('koolclash-nav-config')
                                        E('koolclash-btn-upload').classList.remove('btn-primary');
                                        E('koolclash-btn-upload').classList.add('btn-danger');
                                        E('koolclash-btn-save-dns-config').removeAttribute('disabled');
                                        E('_koolclash-dns-config-switch').checked = true;
                                        E('_koolclash-dns-config-switch').setAttribute('disabled', '');
                                        $('#_koolclash-config-dns').show();
                                        $('#koolclash-btn-save-dns-config').show();
                                        E('koolclash-dns-msg').innerHTML = `Clash 配置文件存在，但配置文件中不存在 DNS 配置或配置不合法，请在下面提交 DNS 配置`;
                                    } else if (resp.result === 'ok' ) {
                                        E('koolclash-btn-upload').innerHTML = 'Clash 配置上传成功，页面将自动刷新<span id="koolclash-wait-time"></span>';
                                        KoolClash.tminus(5);
                                        setTimeout(() => {
                                            window.location.reload();
                                        }, 5000)
                                    } else  {
                                        E('koolclash-btn-upload').innerHTML = '不知道除了什么问题！返回状态码:' + resp.result;
                                        setTimeout(() => {
                                            KoolClash.enableAllButton();
                                            E('koolclash-btn-upload').innerHTML = '上传配置文件';
                                        }, 3000)
                                    }
                                },
                                error: () => {
                                    E('koolclash-btn-upload').innerHTML = '配置文件上传失败！';

                                    setTimeout(() => {
                                        KoolClash.enableAllButton();
                                        E('koolclash-btn-upload').innerHTML = '上传配置文件';
                                    }, 3000)
                                }
                            });
                        })();
                    },
                    error: () => {
                        if (softcenter === 1) {
                            return false;
                        }
                        E('koolclash-btn-save-config').innerHTML = '配置文件上传失败，请重试';

                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            E('koolclash-btn-upload').innerHTML = '上传配置文件';
                        }, 4000)
                    }
                });
            },
            tminus: (second) => {
                setInterval(() => {
                    second--;
                    E('koolclash-wait-time').innerHTML = `（${second}）`;
                }, 1000);
            },
            submitDNSConfig: () => {
                KoolClash.disableAllButton();
                E('koolclash-btn-save-dns-config').innerHTML = '正在提交...';
                let id = parseInt(Math.random() * 100000000),
                    postData,
                    checked;

                if (E('_koolclash-dns-config-switch').checked) {
                    checked = '1';
                } else {
                    checked = '0'
                }

                postData = JSON.stringify({
                    id,
                    "method": "koolclash_save_dns_config.sh",
                    "params": [`${Base64.encode(E('_koolclash-config-dns').value.replace('# 没有找到保存的 Clash 自定义 DNS 配置，推荐使用以下的配置\n', ''))}`, checked],
                    "fields": ""
                });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'nofallbackdns') {
                            E('koolclash-btn-save-dns-config').innerHTML = '不能提交空的 DNS 配置！';
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                E('koolclash-btn-save-dns-config').innerHTML = '提交 Clash 自定义 DNS 设置';
                            }, 4000)
                        } else {
                            E('koolclash-btn-save-dns-config').innerHTML = '提交成功！页面将会自动刷新！<span id="koolclash-wait-time"></span>';
                            KoolClash.tminus(5);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        }
                    },
                    error: () => {
                        E('koolclash-btn-save-dns-config').innerHTML = '提交失败！请重试';
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            E('koolclash-btn-save-dns-config').innerHTML = '提交 Clash 自定义 DNS 设置';
                        }, 4000)
                    }
                });
            },
            submitClashAddNode: () => {
                KoolClash.disableAllButton();
                // E('koolclash-btn-addnode').innerHTML = '正在提交...';
                let id = parseInt(Math.random() * 100000000),
                    postData,
                    checked;

                postData = JSON.stringify({
                    id,
                    "method": "koolclash_main.sh",
                    "params": [ "node_add", `${Base64.encode(E('_koolclash_node_uri').value.replace('\n', ''))}`],
                    "fields": ""
                });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'err') {
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                E('koolclash-node-msg').innerHTML = '提交 Clash 自定义 DNS 设置';
                            }, 4000)
                        } else {
                            E('koolclash-node-msg').innerHTML = '提交成功！页面将会自动刷新！<span id="koolclash-wait-time"></span>';
                            KoolClash.tminus(5);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        }
                    },
                    error: () => {
                        E('koolclash-node-msg').innerHTML = '提交失败！请重试';
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                        }, 4000)
                    }
                });
            },
            submitClashDeleteNode: () => {
                KoolClash.disableAllButton();
                E('koolclash-node-msg').innerHTML = '正在提交...';
                let id = parseInt(Math.random() * 100000000),
                    postData,
                    checked;

                postData = JSON.stringify({
                    id,
                    "method": "koolclash_main.sh",
                    "params": [ "node_delete_one", `${Base64.encode(E('_koolclash-select-nodelist').value)}`],
                    "fields": ""
                });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'err') {
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                E('koolclash-node-msg').innerHTML = '删除DIY节点操作失败!';
                            }, 4000)
                        } else {
                            E('koolclash-node-msg').innerHTML = '节点删除成功！页面将会自动刷新！<span id="koolclash-wait-time"></span>';
                            KoolClash.tminus(5);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        }
                    },
                    error: () => {
                        E('koolclash-node-msg').innerHTML = '提交失败！请重试';
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                        }, 4000)
                    }
                });
            },
            submitClashDeleteAll: () => {
                KoolClash.disableAllButton();
                E('koolclash-node-msg').innerHTML = '正在提交...';
                let id = parseInt(Math.random() * 100000000),
                    postData,
                    checked;

                postData = JSON.stringify({
                    id,
                    "method": "koolclash_main.sh",
                    "params": [ "node_delete_all" ],
                    "fields": ""
                });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'err') {
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                E('koolclash-node-msg').innerHTML = '删除DIY节点操作失败!';
                            }, 4000)
                        } else {
                            E('koolclash-node-msg').innerHTML = '节点删除成功！页面将会自动刷新！<span id="koolclash-wait-time"></span>';
                            KoolClash.tminus(5);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        }
                    },
                    error: () => {
                        E('koolclash-node-msg').innerHTML = '提交失败！请重试';
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                        }, 4000)
                    }
                });
            },
            submitClashSwitchMode: () => {
                KoolClash.disableAllButton();
                E('koolclash-node-msg').innerHTML = '正在提交...';
                let id = parseInt(Math.random() * 100000000),
                    postData,
                    checked;

                postData = JSON.stringify({
                    id,
                    "method": "koolclash_main.sh",
                    "params": [ 
                        "switch_clash_mode",
                        E('_koolclash-select-mode').value,
                    ],
                    "fields": ""
                });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'err') {
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                E('koolclash-node-msg').innerHTML = '切换Clash模式操作失败!';
                            }, 4000)
                        } else {
                            E('koolclash-node-msg').innerHTML = '切换Clash模式成功！页面将会自动刷新！<span id="koolclash-wait-time"></span>';
                            KoolClash.tminus(3);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        }
                    },
                    error: () => {
                        E('koolclash-node-msg').innerHTML = '提交失败！请重试';
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                        }, 4000)
                    }
                });
            },
            submitCFDDNS: () => {
                KoolClash.disableAllButton();
                E('koolclash-node-msg').innerHTML = '正在提交...';
                let id = parseInt(Math.random() * 100000000),
                    postData,
                    checked;

                postData = JSON.stringify({
                    id,
                    "method": "koolclash_main.sh",
                    "params": [ 
                        "save_cfddns",
                        E('_koolclash_cfddns_enable').value,
                        E('_koolclash_cfddns_email').value,
                        E('_koolclash_cfddns_apikey').value,
                        `${Base64.encode(E('_koolclash_cfddns_domain').value)}`,
                        E('_koolclash_cfddns_ttl').value,
                        `${Base64.encode(E('_koolclash_cfddns_ip').value)}`
                    ],
                    "fields": ""
                });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'err') {
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                E('koolclash-node-msg').innerHTML = '保存cfddns操作失败!';
                            }, 4000)
                        } else {
                            E('koolclash-node-msg').innerHTML = '启用cfddns功能成功！页面将会自动刷新！<span id="koolclash-wait-time"></span>';
                            KoolClash.tminus(3);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        }
                    },
                    error: () => {
                        E('koolclash-node-msg').innerHTML = '提交失败！请重试';
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                        }, 4000)
                    }
                });
            },
            restart: () => {
                KoolClash.disableAllButton();
                Msg.show('warning', '正在启动 Clash，请不要刷新或关闭页面！');

                setTimeout(() => {
                    KoolClash.selectTab('koolclash-nav-log');
                    KoolClash.getLog();
                }, 100);

                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_control.sh",
                        "params": ['start'],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    async: true,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'nofile') {
                            Msg.hide('warning');
                            Msg.show('error', '关键文件缺失，Clash 无法启动！');
                            Msg.show('warning', '请不要刷新或关闭页面，务必等待页面自动刷新！<span id="koolclash-wait-time"></span>');
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        } else if (resp.result === 'nodns') {
                            Msg.hide('warning');
                            Msg.show('error', '在 Clash 配置文件中没有找到正确的 DNS 设置！');
                            Msg.show('warning', '请不要刷新或关闭页面，务必等待页面自动刷新！<span id="koolclash-wait-time"></span>');
                            KoolClash.tminus(5);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        } else {
                            Msg.hide('warning');
                            Msg.show('success', 'Clash 成功启动！');
                            Msg.show('warning', '请不要刷新或关闭页面，务必等待页面自动刷新！<span id="koolclash-wait-time"></span>');
                            KoolClash.tminus(5);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        }
                    },
                    error: () => {
                        Msg.show('error', 'Clash (可能)启动失败！请在页面自动刷新之后检查 Clash 运行状态！');
                        Msg.show('warning', '请不要刷新或关闭页面，务必等待页面自动刷新！<span id="koolclash-wait-time"></span>');
                        KoolClash.selectTab('koolclash-nav-log');
                        KoolClash.tminus(5);
                        setTimeout(() => {
                            window.location.reload();
                        }, 5000)
                    }
                });
            },
            stop: () => {
                KoolClash.disableAllButton();
                Msg.show('warning', '正在关闭 Clash，请不要刷新或关闭页面！');

                setTimeout(() => {
                    KoolClash.selectTab('koolclash-nav-log');
                    KoolClash.getLog();
                }, 100);

                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_control.sh",
                        "params": ['stop'],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    async: true,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        Msg.hide('warning');
                        Msg.show('success', 'Clash 成功关闭！');
                        Msg.show('warning', '请不要刷新或关闭页面，务必等待页面自动刷新！<span id="koolclash-wait-time"></span>');
                        KoolClash.tminus(5);
                        setTimeout(() => {
                            window.location.reload();
                        }, 5000)
                    },
                    error: () => {
                        Msg.hide('warning');
                        Msg.show('error', 'Clash (可能)关闭失败！请在页面自动刷新之后检查 Clash 运行状态！');
                        Msg.show('warning', '请不要刷新或关闭页面，务必等待页面自动刷新！<span id="koolclash-wait-time"></span>');
                        KoolClash.tminus(5);
                        setTimeout(() => {
                            window.location.reload();
                        }, 5000)
                    }
                });
            },
            deleteSuburl: () => {
                KoolClash.disableAllButton();
                E('koolclash-btn-del-suburl').innerHTML = `正在删除 Clash 托管配置 URL`;
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_main.sh",
                        "params": ['sub_delete'],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        E('koolclash-btn-del-suburl').innerHTML = `删除成功！`;
                        E('_koolclash_config_suburl').value = '';

                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            E('koolclash-btn-del-suburl').innerHTML = '删除托管 URL（保留 Clash 配置）';
                        }, 2500)
                    },
                    error: () => {
                        E('koolclash-btn-del-suburl').innerHTML = `删除失败！`;

                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            E('koolclash-btn-del-suburl').innerHTML = '删除托管 URL（保留 Clash 配置）';
                        }, 2500)
                    }
                });
            },
            updateRemoteConfig: () => {
                KoolClash.disableAllButton();
                E('koolclash-btn-update-sub').innerHTML = `正在下载最新托管配置`;
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_main.sh",
                        "params": ['sub_update', `${Base64.encode(E('_koolclash_config_suburl').value)}`],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'nocurl') {
                            E('koolclash-btn-update-sub').innerHTML = `你的路由器中没有 curl，不能更新！`;
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                E('koolclash-btn-update-sub').innerHTML = '更新 Clash 托管配置';
                            }, 3500)
                        } else if (resp.result === 'fail') {
                            E('koolclash-btn-update-sub').innerHTML = `Clash 托管配置下载失败！已经自动恢复到旧的配置文件！`;
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                E('koolclash-btn-update-sub').innerHTML = '更新 Clash 托管配置';
                            }, 4000)
                        } else if (resp.result === 'nofallbackdns') {
                            E('koolclash-btn-update-sub').innerHTML = '在托管配置中没有找到 DNS 设置，请在下面添加 DNS 配置！';
                            E('_koolclash-dns-config-switch').checked = true;
                            E('_koolclash-dns-config-switch').setAttribute('disabled', '');
                            $('#_koolclash-config-dns').show();
                            $('#koolclash-btn-save-dns-config').show();
                            E('koolclash-btn-save-dns-config').removeAttribute('disabled');
                            E('koolclash-dns-msg').innerHTML = `Clash 托管配置文件已经更新，但托管配置中不存在 DNS 配置或配置不合法，请在下面提交 DNS 配置`;
                        } else {
                            E('koolclash-btn-update-sub').innerHTML = 'Clash 配置更新成功，页面将自动刷新<span id="koolclash-wait-time"></span>';
                            KoolClash.tminus(5);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        }
                    },
                    error: () => {
                        E('koolclash-btn-update-sub').innerHTML = `Clash 托管配置更新失败！`;

                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            E('koolclash-btn-update-sub').innerHTML = '更新 Clash 托管配置';
                        }, 2500)
                    }
                });
            },
            updateIPDB: () => {
                KoolClash.disableAllButton();
                E('koolclash-btn-update-ipdb').innerHTML = `开始下载最新 IP 解析库并更新`;
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        "id": id,
                        "method": "koolclash_main.sh",
                        "params": ["koolclash_update_mmdb"],
                        "fields": ""
                    });

                setTimeout(() => {
                    KoolClash.selectTab('koolclash-nav-log');
                    KoolClash.getLog();
                }, 100);

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'nodl') {
                            E('koolclash-btn-update-ipdb').innerHTML = `你的路由器中既没有 curl 也没有 wget，不能下载更新！`;
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                E('koolclash-btn-update-ipdb').innerHTML = '更新 IP 数据库';
                            }, 5500)
                        } else {
                            E('koolclash-btn-update-ipdb').innerHTML = `IP 解析库更新成功！页面将自动刷新<span id="koolclash-wait-time"></span>`;
                            KoolClash.tminus(3);
                            setTimeout(() => {
                                window.location.reload();
                            }, 3000)
                        }
                    },
                    error: () => {
                        E('koolclash-btn-update-ipdb').innerHTML = `IP 解析库更新失败！`;
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            E('koolclash-btn-update-ipdb').innerHTML = '更新 IP 数据库';
                        }, 3000)
                    }
                });
            },
            getLog: () => {
                if (typeof _responseLen === undefined) {
                    let _responseLen = 0;
                } else {
                    _responseLen = 0;
                }

                let noChange = 0;

                $.ajax({
                    url: '/_temp/koolclash_log.txt',
                    type: 'GET',
                    cache: false,
                    dataType: 'text',
                    success: (response) => {
                        var retArea = E("_koolclash_log");
                        if (response.search("XU6J03M6") !== -1) {
                            retArea.value = response.replace("XU6J03M6", " ");
                            retArea.scrollTop = retArea.scrollHeight;
                            return true;
                        }
                        if (_responseLen === response.length) {
                            noChange++;
                        } else {
                            noChange = 0;
                        }
                        if (noChange > 8000) {
                            KoolClash.selectTab('koolclash-nav-overview');
                            return false;
                        } else {
                            setTimeout(() => {
                                KoolClash.getLog();
                            }, 100);
                        }
                        retArea.value = response.replace("XU6J03M6", " ");
                        retArea.scrollTop = retArea.scrollHeight;
                        _responseLen = response.length;
                    },
                    error: () => {
                        E("_koolclash_log").value = "获取日志失败！";
                        return false;
                    }
                });
            },
            debugInfo: () => {
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_main.sh",
                        "params": ["koolclash_debug_info"],
                        "fields": ""
                    });

                fetch(`/_api/`, {
                    body: postData,
                    method: 'POST',
                    cache: 'no-cache',
                }).then((resp) => Promise.all([resp.ok, resp.status, resp.json(), resp.headers]))
                    .then(([ok, status, data, headers]) => {
                        if (ok) {
                            return JSON.parse(data.result);
                        } else {
                            throw new Error(JSON.stringify(json.error));
                        }
                    })
                    .then((data) => {
                        let getBrowser = () => {
                            let ua = navigator.userAgent,
                                tem,
                                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
                            if (ua.match("MicroMessenger"))
                                return "Weixin";

                            if (/trident/i.test(M[1])) {
                                tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                                return 'IE ' + (tem[1] || '');
                            }
                            if (M[1] === 'Chrome') {
                                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                            }
                            M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
                            if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
                            return M.join(' ');
                        };

                        E('_koolclash_debug_info').value = `
======================== KoolClash 调试工具 ========================
调试信息生成于 ${new Date().toString()}
当前浏览器：${getBrowser()}
-------------------- Koolshare OpenWrt 基本信息 --------------------
固件版本：${data.koolshare_version}
路由器 LAN IP：${data.lan_ip}
------------------------ KoolClash 基本信息 ------------------------
KoolClash 版本：${window.dbus.koolclash_version}
Clash 核心版本：${data.clash_version}
KoolClash 当前状态：${(window.dbus.koolclash_enable === '1') ? `Clash 进程正在运行` : `Clash 进程未在运行`}
用户指定 Clash 外部控制 Host：${(window.dbus.koolclash_api_host) ? window.dbus.koolclash_api_host : `未改动`}
-------------------------- Clash 进程信息 --------------------------
${Base64.decode(data.clash_process)}
------------------------ Clash 配置文件目录 ------------------------
${Base64.decode(data.clash_config_dir)}
------------------------ Clash 配置文件信息 ------------------------
Clash 透明代理端口：${data.clash_redir}
Clash 是否允许局域网连接：${data.clash_allow_lan}
Clash 外部控制监听地址：${data.clash_ext_controller}
--------------------- Clash 配置文件 DNS 配置 ----------------------
Clash DNS 是否启用：${data.clash_dns_enable}
Clash DNS 解析 IPv6：${(data.clash_dns_ipv6 === 'null') ? `false` : data.clash_dns_ipv6}
Clash DNS 增强模式：${data.clash_dns_mode}
Clash DNS 监听：${data.clash_dns_listen}
KoolClash 当前 DNS 模式：${dbus.koolclash_dnsmode}
-------------------- KoolClash 自定义 DNS 配置 ---------------------
${Base64.decode(data.fallbackdns)}
------------------------- iptables 条目 ---------------------------
 * iptables mangle 中 Clash 相关条目
${Base64.decode(Base64.decode(data.iptables_mangle))}

 * iptables nat 中 Clash 相关条目
${Base64.decode(Base64.decode(data.iptables_nat))}

 * iptables mangle 中 koolclash 链
${Base64.decode(Base64.decode(data.iptables_mangle_clash))}

 * iptables nat 中 koolclash 链
${Base64.decode(Base64.decode(data.iptables_nat_clash))}

* iptables mangle 中 koolclash_dns 链
${Base64.decode(Base64.decode(data.iptables_mangle_clash_dns))}

 * iptables nat 中 koolclash_dns 链
${Base64.decode(Base64.decode(data.iptables_nat_clash_dns))}

 * iptables nat 中 53 端口相关条目
${Base64.decode(data.chromecast_nu)}
---------------------- ipset 白名单 IP 列表 ------------------------
${Base64.decode(data.firewall_white_ip)}
===================================================================
`;
                    })
            },
            acl: {
                submitWhiteIP: () => {
                    KoolClash.disableAllButton();
                    let data = Base64.encode(E('_koolclash_firewall_white_ipset').value);

                    E('koolclash-btn-submit-white-ip').innerHTML = `正在提交`;
                    let id = parseInt(Math.random() * 100000000),
                        postData = JSON.stringify({
                            id,
                            "method": "koolclash_main.sh",
                            "params": ['firewall_white_ip_add', `${data}`],
                            "fields": ""
                        });

                    $.ajax({
                        type: "POST",
                        cache: false,
                        url: "/_api/",
                        data: postData,
                        dataType: "json",
                        success: (resp) => {
                            E('koolclash-btn-submit-white-ip').innerHTML = `提交成功，下次启动 Clash 时生效！`;
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                E('koolclash-btn-submit-white-ip').innerHTML = '提交';
                            }, 2500)
                        },
                        error: () => {
                            E('koolclash-btn-submit-white-ip').innerHTML = `提交失败，请重试！`;
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                E('koolclash-btn-submit-white-ip').innerHTML = '提交';
                            }, 2500)
                        }
                    });
                },
            },
            submitWatchdog: () => {
                KoolClash.disableAllButton();
                E('koolclash-btn-submit-watchdog').innerHTML = `正在提交`;

                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_main.sh",
                        "params": [ "koolclash_watchdog_enable", `${E('_koolclash-select-watchdog').value}`],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        E('koolclash-btn-submit-watchdog').innerHTML = `提交成功，下次启动 Clash 时生效！`;
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            E('koolclash-btn-submit-watchdog').innerHTML = '提交';
                        }, 2500)
                    },
                    error: () => {
                        E('koolclash-btn-submit-watchdog').innerHTML = `提交失败，请重试！`;
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            E('koolclash-btn-submit-watchdog').innerHTML = '提交';
                        }, 2500)
                    }
                });
            },
            load: (cb) => {
                window.dbus = {}
                document.title = 'KoolClash - Clash for Koolshare OpenWrt/LEDE';

                fetch(`/_api/koolclash`, { method: 'GET' })
                    .then((resp) => Promise.all([resp.ok, resp.status, resp.json(), resp.headers]))
                    .then(([ok, status, data, headers]) => {
                        if (ok) {
                            window.dbus = data.result[0];
                            window.dbus.koolclash_cfddns_domain = `${Base64.decode(window.dbus.koolclash_cfddns_domain)}`;
                            window.dbus.koolclash_cfddns_ip = `${Base64.decode(window.dbus.koolclash_cfddns_ip)}`;
                        } else {
                            throw new Error(JSON.stringify(json.error));
                        }
                    })
                    .then((res) => {
                        if (typeof $('#koolclash-field').forms === 'function') {
                            KoolClash.renderUI();
                            E('koolclash-version-msg').innerHTML = `当前安装版本&nbsp;:&nbsp;<span id="koolclash-version-installed" style="color:red; margin-top: 8px">${window.dbus.koolclash_version}</span>`;
                            var obj = E("_koolclash-select-nodelist");
                            obj.options.length = 0;
                            var node_arr;
                            if (window.dbus.koolclash_node_list) {
                                node_arr = window.dbus.koolclash_node_list.trim().split(" ");
                            } else {
                                node_arr = [];
                            }
                            for (let index = 0; index < node_arr.length; index++) {
                                const element = node_arr[index];
                                obj.options.add(new Option(element, element));
                            }
                        } else {
                            console.clear();
                            setTimeout(() => {
                                console.clear();
                                window.location.reload();
                            }, 1000);
                        }
                    })
                    .then((res) => {
                        KoolClash.getClashStatus();
                        //KoolClash.checkUpdate();
                    })
            },
        }

        function verifyFields(r) {
            // 自定义 DNS 配置的显示隐藏
            if ($(r).attr("id") === "_koolclash-dns-config-switch") {
                if (E('_koolclash-dns-config-switch').checked) {
                    $('#_koolclash-config-dns').show();
                    $('#koolclash-btn-save-dns-config').show();
                } else {
                    $('#_koolclash-config-dns').hide();
                    if (window.dbus.koolclash_dnsmode === '1') {
                        $('#koolclash-btn-save-dns-config').hide();
                    }
                }
            }/* else if (r.getAttribute('id') === '_koolclash-acl-default-port') {
                if (E('_koolclash-acl-default-port').value === '0') {
                    $('#_koolclash-acl-default-port-user').show();
                } else {
                    $('#_koolclash-acl-default-port-user').hide();
                }
            }*/
        }
    </script>
    <script>
        KoolClash.load();
    </script>
    
</content>
