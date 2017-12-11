# 持续集成使用说明(未完)
项目持续运行,需要纳入持续集成系统管控.
持续集成地址:
http://jenkins.yirong.win:10000/jenkins


## 运行中项目
+ bidspy
    + bidspy_build_all
    + bidspy_test
    
+ spider
    + spider_build_all
    + bidspy_test


## 持续集成使用说明
持续集成暂由bansin组成员添加

需向basin成员提交以下内容:

1. 项目地址 git/svn
2. 需要的环境变量,例如
>export PRIVATE_REGISTRY=10.142.55.199:5006

3. 编译脚本(build.sh) 内容由开发人员自行编写,但本地执行build.sh在能build.sh编译完整部署包.
4. 测试脚本(test.sh) 内容由开发人员自行编写,本地执行test.sh能正常测试通过.
5. 成功/失败接收邮箱账号
6. 是否需每日构建

## 使用过程
除了配置实时构建以及每日构建外,用户可以自行编译.
提供两种操作方式:
1. web 操作

    登录: http://jenkins.yirong.win:10000/jenkins
    + 账号: jenkins
    + 密码: jenkins
    点击项目编译.
2. 命令行操作:
    ~~~
    curl -X POST http://jenkins:jenkins@115.28.208.122:17000/jenkins/job/build_bidspy/build
    ~~~
 编译结果见basin监控平台(待完善)
 

