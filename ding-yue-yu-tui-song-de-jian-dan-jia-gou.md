## Order Model

- user (userid, 权限，限制)
- source (源数据，爬虫或爬虫组，或者抽取结果？ )
- fields （？ 比如所需的招标公告的列，需要先请求某些服务 获得当前fields列表）
- internval time (实时 每天 每周 每月？)
- subscribe_type (订阅方式, 邮箱 ，app推送 )

## Source Model

- name
- type(爬虫，爬虫组，外部服务)

由管理员配置。
根据type 在对应的table (source-爬虫，source-爬虫组，source-外部服务) 找相应的model。（先不做，按单个爬虫来）


## Scheduler 

定时扫描 order 表，执行定制任务（发送订阅到 邮箱？）