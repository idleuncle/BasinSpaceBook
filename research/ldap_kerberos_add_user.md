# 说明

所有docker contianer 都运行在 199 上，可以直接进入操作


## 添加ldap 用户或组织

进入docker

    docker exec -it ldap bash

### 方法一：修改配置文件

这里不使用/etc/openldap/slapd.conf 编辑配置，这种方式很繁琐，需要

1. 修改配置文件，添加新用户 `/etc/openldap/slapd.conf`
2. 重新生成目录 `slaptest -f /etc/openldap/slapd.conf -F /etc/openldap/slapd.d/`
3. 授权 `chown -R ldap.ldap /etc/openldap/slapd.d/`
4. 重启 `/etc/init.d/slapd restart`

### 方法二：使用ldif文件

详见：[6.2 ldap添加用户组织手册](research/ldap_manual.md)

创建一个添加数据的文件（下面添加了一个组织organizationalUnit 和 一个人物person）

    dn: ou=Marketing, dc=example,dc=com
    changetype: add
    objectclass: top
    objectclass: organizationalUnit
    ou: Marketing

    dn: cn=Pete Minsky,ou=Marketing,dc=example,dc=com
    changetype: add
    objectclass: person
    objectclass: organizationalPerson
    objectclass: inetOrgPerson
    cn: Pete Minsky
    sn: Pete
    ou: Marketing
    description: sb, sx
    description: sx
    uid: pminsky

添加命令：

    ldapmodify -a -xWD 'cn=admin,dc=example,dc=com' -f add_entry.ldif

对于kerberos认证的用户，需要添加posixAccount 的无密码用户

### ldap的一些 web admin

https://github.com/Accenture/adop-ldap-phpadmin

这个不支持TLS，所以无法支持kerberos
https://github.com/aster1sk/easyldap


## Kerberos 添加用户


### 进入docker

    docker exec -it kerberos bash

### 添加用户


普通用户只需设置kerberos的密码

    kadmin.local -q "addprinc -pw kuser01 user01"

会创建user01，密码是kuser01


注意：所有用户必须在ldap中实现创建，才能在Kerberos里添加

特殊的是admin，必须提供ldap里的admin密码：

    kadmin.local -q "addprinc -pw admin admin/admin"



# 其他

看了挺多文章，实在觉得kerberos只是用来做机器认证的
kerberos+ldap的用户管理非常复杂

看了很多文章，感觉下面这个提到的 ipa-server ， 统一管理用户还不错
https://ieevee.com/tech/2016/06/21/kerberos-3.html



