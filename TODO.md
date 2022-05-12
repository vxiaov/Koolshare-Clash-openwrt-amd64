# 开发功能计划
> 利用业余时间做点东西，给枯燥的路由器增加点乐趣。

想到的功能就记下来，关键功能先开发出来了，附加的功能不必要、也不一定有用，有兴致了就搞搞。

配置文件

## TODO

- [x] 分支Koolclash，定制UI优化，去掉测速、版本检查等功能。
- [x] 增加yacd界面
- [x] 优化Country.mmdb更新地址。
- [x] 命令升级:clash升级为[Clash Premium 2021.09.15 版本](https://github.com/vlikev/clash_binary/tree/f3c4db627f8d091682dc26d5bfe5efd7ad93a8f4/premium/), `yq`由升级**2.x**升级到[yq 4.24.5 版本](https://github.com/mikefarah/yq/).
- [x] 增加个人DIY节点添加、删除功能，增加[uridecoder命令](https://github.com/learnhard-cn/uridecoder)实现节点URI解析功能。节点配置保存在 **providers/provider_diy.yaml**文件中，想使用就添加个文件订阅配置。
- [x] 功能脚本合并到一个脚本: koolclash_main.sh ,减少冗余配置。
- [x] 增加了默认启动配置文件，**安装即用**。
- [x] 为主路由增加了监控旁路由上、下线并自动更改配置功能(脚本部署在主路由器端)。
- [ ] 增加 proxy_provider 订阅源管理功能。
- [ ] 增加 proxy-group 代理组管理功能,配置proxy-group组可以选择哪些 proxy_provider。
- [ ] 增加 rule 规则管理功能。


## 增加proxy_provider订阅源管理功能

1. 添加 proxy_provider : 参数有 name,type(file/http), content(upload/url) , 提交后，更新 config.yaml的 proxy-providers 信息.
2. 删除 proxy_provider : 参数有select选择项 name ,提交后 删除 config.yaml 中与 proxy-providers 和 proxy-groups 中包含 name 的所有信息。
3. 更新 proxy_provider : 参数有 select选择 name，选择后获取并显示 ~~name(不可修改),~~type,content信息进行修改，提交后，更新 config.yaml 中的 proxy-providers内容.
4. 查看 proxy_provider : 参数无， 只有一个查询按钮，获取 provider 列表名称。



