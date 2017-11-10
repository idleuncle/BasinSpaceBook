## 部署说明
使用一台vagrant 作为部署服务器,暂定jenkins(进行构建)

## 操作说明
登录: http://115.28.208.122:17000/jenkins
账号: jenkins/jenkins

**点击编译项目 build_bidspy 进行编译.**

+ 命令行操作:

~~~
启动编译命令
curl -X POST http://jenkins:jenkins@115.28.208.122:17000/jenkins/job/build_bidspy/build
~~~

生成dist文件存在 /root/workspace/build_bidspy/dist
**!! 需要增加发布服务器/ftp等,存放.**

