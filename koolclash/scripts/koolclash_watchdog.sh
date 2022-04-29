#!/bin/sh
########################################
### 功能: 守护进程的监控脚本
###     定时检查进程是否存在，间隔 15秒
###
########################################

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval $(dbus export koolclash_)
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

while [ "$koolclash_enable" == "1" ]; do
    echo_date "开始检查进程状态..."

    if [ ! -n "$(pidof clash)" ]; then
        start-stop-daemon -S -q -b -m \
            -p /tmp/run/koolclash.pid \
            -x /koolshare/bin/clash \
            -- -d $KSROOT/koolclash/config/
        echo_date "重启 Clash 进程"
    fi

    sleep 15
    continue
done
