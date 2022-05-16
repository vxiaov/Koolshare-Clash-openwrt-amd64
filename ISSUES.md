# 记录一些问题的解决方法和过程

## Clash关于DNS配置问题

Clash的DNS异常(DNS服务器不应答)会导致内存占用不断增加，比如，我在路由器上最开始启动时**Clash进程只占用了60-80MB内存资源**，由于我配置了多个DNS服务器，其中有一个**无效(被墙或者其他原因吧)**的`DoT`地址(**https://1.1.1.1/dns-query**)，然后运行了2个小时后内存资源占用达到了**200MB**左右，这基本上占满了路由器的内存。


**解决方法:**

既然是DNS无应答导致问题，那就去掉无效的DNS服务器地址呗。

虽然UDP协议的DNS协议不安全，但目前来看还是不得不用，如下是我的DNS配置:

```yaml
# 透明代理开启DNS
dns:
  enable: true
  ipv6: false
  listen: 0.0.0.0:1053
  enhanced-mode: redir-host # redir-host or fake-ip
  use-hosts: false # lookup hosts and return IP record
  nameserver:
    # - 114.114.114.114
    - https://dns.alidns.com/dns-query
  # 提供 fallback 时，如果GEOIP非 CN 中国时使用 fallback 解析
  fallback:
    - 1.1.1.1 # cloudflare DNS UDP
    - 8.8.8.8 # Google DNS UDP
    # - https://cloudflare-dns.com/dns-query # cloudflare DNS over HTTPS
    # - https://dns.google/dns-query # Google DNS over HTTPS
    # - tls://1.1.1.1:853 # cloudflare DNS over TLS
    # - tls://8.8.8.8:853 # Google DNS over TLS
  # 强制DNS解析使用`fallback`配置
  fallback-filter:
    # true: CN使用nameserver解析，非CN使用fallback
    geoip: true
    # geoip设置为false时有效： 不匹配`ipcidr`地址时会使用`nameserver`结果，匹配`ipcidr`地址时使用`fallback`结果。
    ipcidr:
      - 240.0.0.0/4

```

> 最后，通过`htop`和`lsof`命令分析了一段时间，**内存资源增长问题终于解决了**,这个问题并不能算是Clash的bug，而只能算做配置不当引起的问题，以后配置规则的标准是 **需要的配置，多余的必须删掉/注释掉.**。



如果你想分析你的Clash是否存在这样的问题，你需要在你的路由器上安装`htop`和`lsof`命令。

`htop`命令更只管查看进程资源使用情况(配合htop和lsof使用)，`lsof`命令分析进程都打开了哪些资源文件(包括网络连接),执行下面命令查看`SYN_SEND`状态的链接(其中32137是clash进程ID):

    lsof -p 32137|grep SYN

如果输出中包含你的DNS地址，那就是DNS服务器无法连接了，**换个公开的DNS服务器地址**就可以了。


```
clash   32137 root    7u     inet 1787119      0t0     TCP 123.123.123.123:54566->169.197.142.187:https (SYN_SENT)
clash   32137 root    9u     inet 1787121      0t0     TCP 123.123.123.123:54004->38.91.102.86:https (SYN_SENT)
clash   32137 root   11u     inet 1787145      0t0     TCP 123.123.123.123:58065->1.1.1.1:853 (SYN_SENT)


```

看到了第三行中**1.1.1.1:853**是我配置的**DoT类型DNS服务器地址**，对于我的网络无法使用它，只能注释掉这个配置了。


看到这里，你是否明白Clash内存增长的原因了呢？如果你有这样的问题，就将无效的DNS配置删掉后重启试试吧。


## TODO


---

