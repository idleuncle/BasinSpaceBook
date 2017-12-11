
# 发现问题
在开发过程中经常会出现如下问题:
1. 需要提交部署包时,开发人员立即去编译,但是对编译的部署包未经过严格测试(质量没保障)
2. 在开发过程中,经常需要修改代码,但代码未及时做集成测试.
3. 静态代码检测
4. 基于docker化部署,编译的版本有可能引入外部库版本,造成代码不可控.

# 解决方案
1. 引入持续集成机制,来保证实时程序的稳定和质量.
2. 及时自动化构建并执行测试发现程序中的bug
3. 静态代码编译检查
4. 编译过程检测依赖的外部库,是否在私有仓库中,如不在仓库中就停止编译.

## 实时编译:
用户提交编译自动构建
~~~
digraph graphname{

    User [label="User"]      // node T
    Ci [label="CI Server"]  // node P
    Repo [label="Repo"]
    Build_server [label="Build Server"]
    Test_server [label="Test Server"]

    User->Repo [label="check in"] // edge T->P
    User->Ci [label="触发"]
    Ci-> Build_server [label="build"]
    Build_server -> Ci [label="build result"]

    Ci -> Test_server [label="testing"]
    Test_server-> Ci [label="test result"]

    Ci -> User [label="通知结果"]

}

~~~

![](/graphics/realtime.png)





## 每日构建:

由构建系统每日构建
~~~
digraph graphname{

    User [label="User"]      // node T
    Ci [label="CI Server"]  // node P
    Repo [label="Repo"]
    Build_server [label="Build Server"]
    Test_server [label="Test Server"]

    
    Ci -> Repo [label="(1)git pull"]
    Ci-> Build_server [label="(2)build"]
    Build_server -> Ci [label="(3)build result"]

    Ci -> Test_server [label="(4)testing"]
    Test_server-> Ci [label="(5)test result"]

    Ci -> User [label="(6)通知结果"]


}

~~~


![](/graphics/daybuild.png)


## 用户触发
由用户触发构建
~~~
digraph graphname{

    User [label="User"]      // node T
    Ci [label="CI Server"]  // node P
    Repo [label="Repo"]
    Build_server [label="Build Server"]
    Test_server [label="Test Server"]

    
    User -> Ci [label="(1)build command"]
    Ci -> Repo [label="(2)git pull"]
    Ci-> Build_server [label="(3)build"]
    Build_server -> Ci [label="(4)build result"]

    Ci -> Test_server [label="(5)testing"]
    Test_server-> Ci [label="(6)test result"]

    Ci -> User [label="(7)通知结果"]


}


~~~

![](/graphics/userbuild.png)






# 验证模型
1. 基础镜像自动构建导入仓库,不输入版本号,即为latest,编译变进入私有仓库.
2. 自动化构建应用系统,(已验证)
3. 编译应用系统前,检测依赖库是否属于私有仓库.并且不能使用latest.
4. 编译成功/失败次数统计


## 问题总结
1. 当前bidspy 包含了爬虫和抽取, 爬虫和抽取应该提取出来.作为各自独立项目,存放在gitlab仓库中,bidspy 构建时候从仓库中导出该镜像,这样能够使爬虫和抽取独立部署.
2. 编译未检测是否私有仓库中版本.
3. 此模型能验证应用系统和基础镜像(基础依赖库)持续构建



