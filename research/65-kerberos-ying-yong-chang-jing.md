
# Kerberos 原理

　Kerberos简单来说就是一个用于安全认证第三方协议，它采用了传统的共享密钥的方式，实现了在网络环境不一定保证安全的环境下，client和server之间的通信，适用于client/server模型，由MIT开发和实现。

　　Kerberos的神秘之处在于，它并不要求通信双方所在的网络环境是安全的，即使通信过程中数据被截取或者篡改依然不会影响它的正常工作，它提供的认证是双向的，不仅能保证Server不被错误的Client使用，同时也能保证Client不使用错误的Server。同时Kerberos又严重依赖于时间，时间戳也是Kerberos用来保证通信安全的重要手段，这个一般通过通信双方同时访问同一个时间服务器来实现。Kerberos也能达到单点登录的效果，即当Client通过了Kerberos server的认证后，便可以访问多个Real Server。

# 前提条件

在协议工作前，kerberos KDC在自己数据库中已经存有各个Client和Service Server的基本信息（帐号、密码……）和自己（KDC）的密码，由于协议中的消息无法穿透防火墙，所以Kerberos协议往往用于一个组织的内部， 使其应用场景不同于X.509 PKI。

经过大量文章阅读，发现这个软件必须以system为最小单位安装（虚拟机或者docker容器），能够授权的也仅仅是使用这个system的用户。并且要求用户手动进行鉴权等操作命令，不适用于一般用户场景。

# Kerberos 应用场景


YARN认证
目的是将YARN接入到kerberos集群里，使得：

RM和NM之间能互相认证，避免混进去恶意服务；
其他提交到YARN上的JOB必须能够通过kerberos认证，避免无证商户提交作业到YARN集群上去。


Spark作业认证
目的是spark-submit提交作业的时候，能够接入到kerberos中，从而向YARN提交作业、访问HDFS等等。


Hive认证
hive支持三种：Kerberos、LDAP、CUSTOM（自定义插件）。如果使用 Kerberos 身份验证，Thrift 客户端和 HiveServer2 以及 HiveServer2 和安全 HDFS 之间都支持身份验证。如果使用 LDAP 身份验证，仅在 Thrift 客户端和 HiveServer2 之间支持身份验证（CUSTOM类似）。


Spark SQL Thriftserver认证
目的是让不同的用户，使用不同的身份来登录beeline。