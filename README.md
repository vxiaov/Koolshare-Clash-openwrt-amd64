<h1 align="center">
    <img src="https://github.com/learnhard-cn/clash/raw/main/clash/res/icon-clash.png" alt="Clash" width="120">
    <br>KoolClash
</h1>

<p align="center">
A rule based custom proxy for <strong>Koolshare OpenWrt/LEDE x64</strong> based on <a href="https://github.com/Dreamacro/clash" target="_blank">Clash</a>.
<br>
<a href="https://koolclash.js.org">Documentation(zh-Hans)</a> |
<a href="https://github.com/learnhard-cn/Koolshare-Clash-openwrt-amd64/releases">Download</a>
</p>

<p align="center">
    <!--<a href="https://travis-ci.org/SukkaW/KoolShare-Clash">
        <img src="https://img.shields.io/travis/SukkaW/KoolShare-Clash.svg?style=flat-square" alt="Travis-CI">
    </a>-->
    <a href="https://github.com/learnhard-cn/Koolshare-Clash-openwrt-amd64/releases" target="_blank">
        <img src="https://img.shields.io/github/release/learnhard-cn/Koolshare-Clash-openwrt-amd64/all.svg?style=flat-square">
    </a>
    <a href="https://github.com/Dreamacro/clash" target="_blank">
        <img src="https://img.shields.io/badge/Clash-0.15.0-1c4070.svg?style=flat-square"/>
    </a>
    <a href="https://github.com/learnhard-cn/Koolshare-Clash-openwrt-amd64/blob/master/LICENSE" target="_blank">
        <img src="https://img.shields.io/github/license/sukkaw/koolshare-clash.svg?style=flat-square"/>
    </a>
    <a href="https://github.com/learnhard-cn/Koolshare-Clash-openwrt-amd64/releases" target="_blank">
        <img src="https://img.shields.io/github/downloads/sukkaw/koolshare-clash/total.svg?style=flat-square"/>
    </a>
</p>

<p align="center">
    <img src="https://i.loli.net/2019/04/16/5cb5e4b579a44.png">
</p>

> KoolClash is for `Koolshare OpenWrt/LEDE x86_64` ONLY. Use [OpenClash](https://github.com/vernesong/OpenClash/) if you are running original OpenWrt.

## Keywords

- [Clash](https://github.com/Dreamacro/clash) : A multi-platform & rule-base tunnel
- **[KoolClash](https://github.com/learnhard-cn/Koolshare-Clash-openwrt-amd64) : This project, a rule based custom proxy for [Koolshare OpenWrt/LEDE x64](https://fw.koolcenter.com/LEDE_X64_fw867/) based on Clash.**

## Features

- HTTP/HTTPS and SOCKS protocol
- Surge like configuration
- GeoIP rule support
- Support Vmess/Shadowsocks/Socks5
- Support for Netfilter TCP redirect

Besides those features that Clash have, KoolClash has more:

- Install clash and upload config to [Koolshare OpenWrt/LEDE X86](https://fw.koolcenter.com/LEDE_X64_fw867/)
- Transparent proxy for all of your devices


## Installation

Download latest `koolshare.tar.gz` from [GitHub Release](https://github.com/learnhard-cn/Koolshare-Clash-openwrt-amd64/releases), and then upload to Koolshare OpenWrt/LEDE Soft Center as offline installation.

Read the [detailed installation instructions (written in Chinese)](https://koolclash.js.org/#/install) for more details.

## Build

```bash
$ git clone https://github.com/learnhard-cn/Koolshare-Clash-openwrt-amd64.git
$ cd Koolshare-Clash-openwrt-amd64
$ ./build # Get usage information
$ ./build pack # Build the package
$ ./build geoip # Update Country.mmdb to latest
$ ./build yacd  # Update clash-dashboard to latest
$ ./build all   # Update all resources and build package
```

## Clash on Other Platforms

- [Clash for Windows](https://github.com/Fndroid/clash_for_windows_pkg) : A Windows GUI based on Clash
- [clashX](https://github.com/yichengchen/clashX) : A rule based custom proxy with GUI for Mac base on clash
- [ClashA](https://github.com/ccg2018/ClashA) : An Android GUI for Clash
- [OpenClash](https://github.com/vernesong/OpenClash) : Another Clash Client For OpenWrt


## License

KoolClash is released under the GPL-3.0 License - see the [LICENSE](https://github.com/learnhard-cn/Koolshare-Clash-openwrt-amd64/blob/master/LICENSE) file for details.

Also, this project includes [GeoLite2](https://dev.maxmind.com/geoip/geoip2/geolite2/) data created by [MaxMind](https://www.maxmind.com).

## Disclaimer

KoolClash is not responsible for any loss of any user, including but not limited to Kernel Panic, device fail to boot or can not function normally, storage damage or data loss, atomic bombing, World War III, The CK-Class Restructuring Scenario that SCP Foundation can not prevent, and so on.

## Sponsors


[低价VPS测评及推荐](https://vlike.work/all_cheap_vps.html)

## Maintainer

**KoolClash** © [Sukka](https://github.com/SukkaW), Released under the [GPL-3.0]([./LICENSE](https://github.com/learnhard-cn/Koolshare-Clash-openwrt-amd64/blob/master/LICENSE)) License.<br>
Authored and maintained by [Awkee](https://github.com/Awkee) with help from contributors ([list](https://github.com/learnhard-cn/Koolshare-Clash-openwrt-amd64/contributors)).

> [Blog](https://vlike.work) · GitHub [@Awkee](https://github.com/Awkee) · Telegram Channel [@free_proxy_001](https://t.me/free_proxy_001)
