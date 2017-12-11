# 发现问题
1. bidspy工程中包含了spider,exteact等,部署需要全部部署,不利spider,extract等单独部署,代码也耦合在bidspy中.
2. 随着应用层次分层,spider,extract等属于basin模块,应该能够单独自部署和单独测试,形成闭环, 工程代码在bidspy中,就容易造成所有测试及部署代码.都混在一起.

# 解决问题
1. 提取spider,extract等属于basin模块代码,各自存放git工程,在工程内部包含了各自模块的独立部署和独立测试代码,形成闭环.
2. bdispy等应用系统需要依赖basin模块代码,只需要从私有仓库中获取最新的版本打包部署.

![](/graphics/bidspy_ori.png)

调整目录后
![](/graphics/bidspy_change.png)

