# pull 镜像

docker pull antagme/ldap_gssapi

docker pull antagme/kerberos

docker pull antagme/client_gssapi

docker pull antagme/kerberos:supervisord


# 自动构建脚本

bidspy/scripts/init_ldap_kerberos.sh


# 启动 container

Create Docker Network
docker network create --subnet 172.18.0.0/16 -d bridge ldap

Run Docker LDAP
docker run --name ldap --hostname ldap.edt.org --net ldap --ip 172.18.0.2  --detach antagme/ldap_gssapi

Run Docker Kerberos (TGT)
docker run --name kerberos --hostname kserver.edt.org --net ldap --ip 172.18.0.3  --detach antagme/kerberos:supervisord

Run client
docker run --name client --hostname client.edt.org --net ldap --ip 172.18.0.8 --detach antagme/client_gssapi


# 设置kerberos

    docker exec --interactive --tty kerberos bash

    kadmin.local -q "addprinc -pw randkey ldap/ldap.edt.org"
    kadmin.local -q "addprinc -pw admin admin/admin"
    kadmin.local -q "addprinc -pw kuser01 user01"


验证

    cat /var/kerberos/krb5kdc/kadm5.acl

中有 */admin@EDT.ORG *
// Note: This Means All principal entries like blablabla/admin have Admin permission.
https://github.com/antagme/Documentation_Project/blob/master/example3.md

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

检查 ticket gathering is correct

    [root@client /]# klist
    Ticket cache: FILE:/tmp/krb5cc_0
    Default principal: user01@EDT.ORG

    Valid starting     Expires            Service principal
    01/09/18 02:07:29  01/10/18 02:07:29  krbtgt/EDT.ORG@EDT.ORG


# set GSSAPI openldap

    docker exec -it ldap bash

已经装好下面的包 不用再装

    yum install cyrus-sasl-gssapi cyrus-sasl-ldap

openldap的配置文件默认是 cn=config configuration method, where the LDAP server will be configured via a separate data tree in the directory (which is usually represented as LDIF files under /etc/ldap/slapd.d 或者  /etc/openldap/slapd.d.

相关配置路径在`/etc/openldap`

OpenLDAP的相关配置文件信息:

    /etc/openldap/slapd.conf：OpenLDAP的主配置文件，记录根域信息，管理员名称，密码，日志，权限等
    /etc/openldap/slapd.d/*：这下面是/etc/openldap/slapd.conf配置信息生成的文件，每修改一次配置信息，这里的东西就要重新生成
    /etc/openldap/schema/*：OpenLDAP的schema存放的地方
    /var/lib/ldap/*：OpenLDAP的数据文件
    /usr/share/openldap-servers/slapd.conf.obsolete 模板配置文件
    /usr/share/openldap-servers/DB_CONFIG.example 模板数据库配置文件


添加配置文件

    #
    # See slapd.conf(5) for details on configuration options.
    # This file should NOT be world readable.
    #

    include     /etc/openldap/schema/corba.schema
    include     /etc/openldap/schema/core.schema
    include     /etc/openldap/schema/cosine.schema
    include     /etc/openldap/schema/duaconf.schema
    include     /etc/openldap/schema/dyngroup.schema
    include     /etc/openldap/schema/inetorgperson.schema
    include     /etc/openldap/schema/java.schema
    include     /etc/openldap/schema/misc.schema
    include     /etc/openldap/schema/nis.schema
    include     /etc/openldap/schema/openldap.schema
    include     /etc/openldap/schema/ppolicy.schema
    include     /etc/openldap/schema/collective.schema

    # Allow LDAPv2 client connections.  This is NOT the default.
    allow bind_v2

    pidfile     /var/run/openldap/slapd.pid
    #argsfile   /var/run/openldap/slapd.args

    # Limit SASL options to only GSSAPI and not other client-favorites. Apparently there is an issue where
    # clients will default to non-working SASL mechanisms and will make you angry.
    sasl-secprops noanonymous,noplain,noactive

    # SASL connection information. The realm should be your Kerberos realm as configured for the system. The
    # host should be the LEGITIMATE hostname of this server
    sasl-realm EDT.ORG

    # Rewrite certain SASL bind DNs to more readable ones. Otherwise you bind as some crazy default
    # that ends up in a different base than your actual one. This uses regex to rewrite that weird
    # DN and make it become one that you can put within your suffix.
    authz-policy from
    authz-regexp "^uid=[^,/]+/admin,cn=edt\.org,cn=gssapi,cn=auth" "cn=Manager,dc=edt,dc=org"
    authz-regexp "^uid=([^,]+),cn=edt\.org,cn=gssapi,cn=auth" "cn=$1,ou=usuaris,dc=edt,dc=org"
    # ------------------------------------------------------------------------------------------------------------
    # SSL certificate file paths
    TLSCACertificateFile /etc/ssl/certs/cacert.pem
    TLSCertificateFile /etc/openldap/certs/ldapcert.pem
    TLSCertificateKeyFile /etc/openldap/certs/ldapserver.pem
    TLSCipherSuite HIGH:MEDIUM:+SSLv2
    TLSVerifyClient allow

    # -----------------------------------------------

    database hdb
    suffix "dc=edt,dc=org"
    rootdn "cn=Manager,dc=edt,dc=org"
    rootpw {SASL}admin/admin@EDT.ORG
    directory /var/lib/ldap
    index objectClass eq,pres

    access to attrs=userPassword
    by anonymous auth
    by self write

    access to *
    by peername.ip=172.18.0.0%255.255.0.0 read
    by * read break


重新生成配置文件信息文件

    先检测/etc/openldap/slapd.conf是否有错误：slaptest -f /etc/openldap/slapd.conf

    删除最先的配置文件生成的信息：rm -rf /etc/openldap/slapd.d/*
    重新生成：slaptest -f /etc/openldap/slapd.conf -F /etc/openldap/slapd.d/
    查看是否生成的是自己修改的配置文件信息：cat /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{2\}bdb.ldif

    授权：chown -R ldap.ldap /etc/openldap/slapd.d/
    重启：/etc/init.d/slapd restart

# import keytab

    kadmin -p admin/admin
    Authenticating as principal admin/admin with password.  # 前面设置的密码是 admin
    Password for admin/admin@EDT.ORG:
    kadmin: ktadd -k /etc/krb5.keytab ldap/ldap.edt.org


# 测试 ldap perform properly REGEX filtering

    ldapwhoami -h ldap.edt.org -D 'dc=edt,dc=org' -Y GSSAPI -ZZ

#  Perform a ldapsearch command for being secure about our success.

    ldapsearch -h ldap.edt.org -Y GSSAPI -b 'dc=edt,dc=org' -ZZ cn=user01

# 配置 ldap.conf

路径： /etc/openldap/ldap.conf

    ```
    # OpenLDAP client configuration file. Used for host default settings

    BASE            dc=edt,dc=org
    URI             ldap://ldap.edt.org/
    SASL_MECH GSSAPI
    SASL_REALM EDT.ORG
    TLS_CACERT      /etc/ssl/certs/cacert.pem
    #TLS_CACERTDIR    /etc/openldap/certs/
    #TLS_REQCERT     allow
    #SASL_NOCANON on
    ```
