# 架构图

![](/assets/ldap_kerberos.png)

# pull 镜像

docker pull antagme/ldap_sssd

docker pull antagme/kerberos

docker pull antagme/client:pam_tls

docker pull antagme/kerberos:supervisord


# 自动构建脚本

bidspy/scripts/init_ldap_kerberos.sh


# 启动 container

Docker Network
    
    docker network create --subnet 172.18.0.0/16 -d bridge ldap

LDAP
    
    docker run --name ldap --hostname ldap.edt.org --net ldap --ip 172.18.0.2  --detach antagme/ldap_sssd

Kerberos (TGT)
    
    docker run --name kerberos --hostname kserver.edt.org --net ldap --ip 172.18.0.3  --detach antagme/kerberos:supervisord

client
    
    docker run --name client --hostname client.edt.org --net ldap --ip 172.18.0.8 --detach antagme/client:pam_tls


# 设置kerberos

    docker exec --interactive --tty kerberos bash
    kadmin.local -q "addprinc -pw randkey ldap/ldap.edt.org"
    kadmin.local -q "addprinc -pw admin admin/admin"
    kadmin.local -q "addprinc -pw kuser01 user01"

验证

    cat /var/kerberos/krb5kdc/kadm5.acl

中有 `*/admin@EDT.ORG *`

# 配置krb5

3 Containers , 必须有相同的 /etc/krb5.conf

如下 （上述镜像已经设置好了）

    [logging]
      default = FILE:/var/log/krb5libs.log
      kdc = FILE:/var/log/krb5kdc.log
      admin_server = FILE:/var/log/kadmind.log
    [libdefaults]
      dns_lookup_realm = false
      ticket_lifetime = 24h
      renew_lifetime = 7d
      forwardable = true
      rdns = false
      default_realm = EDT.ORG
    [realms]
      EDT.ORG = {
      kdc = kserver.edt.org
      admin_server = kserver.edt.org
      }
    [domain_realm]
     .edt.org = EDT.ORG
    edt.org = EDT.ORG


# 如果修改了上面那些配置文件，需要重启supervisor

    supervisorctl restart all

#  测试client

进入client 机

    docker exec -it client bash

获取 user01 的 ticket， 提示输入密码，输入之前设置的 kuser01

    [root@client /]# kinit user01

检查 ticket 是否正确

    [root@client /]# klist
    Ticket cache: FILE:/tmp/krb5cc_0
    Default principal: user01@EDT.ORG

    Valid starting     Expires            Service principal
    01/09/18 02:07:29  01/10/18 02:07:29  krbtgt/EDT.ORG@EDT.ORG

# SSSD

SSSD是一个守护进程，该进程可以用来访问多种验证服务器，如LDAP，Kerberos等，并提供授权。SSSD是介于本地用户和数据存储之间的进程，本地客户端首先连接SSSD，再由SSSD联系外部资源提供者(一台远程服务器)。

优点：

1.避免了本地每个客户端程序对认证服务器大量连接，所有本地程序仅联系SSSD，由SSSD连接认证服务器或SSSD缓存，有效的降低了负载。

2.允许离线授权。SSSD可以缓存远程服务器的用户认证身份，这允许在远程认证服务器宕机是，继续成功授权用户访问必要的资源。

配置SSSD

    [sssd]
    config_file_version = 2
    domains = default
    services = pam, nss

    [domain/default]
    id_provider = ldap
    ldap_uri = ldap://172.18.0.2
    ldap_search_base = dc=edt,dc=org
    auth_provider = krb5
    chpass_provider = krb5
    krb5_realm = EDT.ORG
    krb5_server = 172.18.0.3
    krb5_kpasswd = 172.18.0.3
    cache_credentials = True
    krb5_store_password_if_offline = True

    [nss]
    filter_groups = root
    filter_users = root
    reconnection_retries = 3

    [pam]
    reconnection_retries = 3
    offline_credentials_expiration = 2
    offline_failed_login_attempts = 3
    offline_failed_login_delay = 5

# 配置 authconfig

    vim /etc/sysconfig/authconfig

写入下面内容

    IPADOMAINJOINED=no
    PASSWDALGORITHM=sha512
    USESSSD=yes
    USEMKHOMEDIR=no
    USEDB=no
    USEPASSWDQC=no
    USESSSDAUTH=yes
    USEHESIOD=no
    CACHECREDENTIALS=yes
    USESYSNETAUTH=no
    USEECRYPTFS=no
    USESMARTCARD=no
    USEWINBINDAUTH=no
    USEIPAV2=no
    USELDAP=yes
    WINBINDKRB5=no
    USELOCAUTHORIZE=yes
    USEKERBEROS=yes
    USELDAPAUTH=no
    USEPAMACCESS=no
    USEWINBIND=no
    FORCELEGACY=no
    USEPWQUALITY=yes
    USENIS=no
    FORCESMARTCARD=no
    USESHADOW=yes
    USEFPRINTD=no
    IPAV2NONTP=no

更新配置

    authconfig --update