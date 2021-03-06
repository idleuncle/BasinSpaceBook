# 平台前端框架


## 概述

一个平台产品少不了一个管理后台用于支持。目前已有大量产品使用bootstrap等前端CSS框架设计的Admin模板，或者与某种语言嵌合的脚手架程序。但管理后台已经开始转向前后端分离，前端可以方便的移植到各种系统中。后端只要提供适配接口。这种方式主要是使用nodejs 构建前端，后端并无限制，比较灵活，也是近年的发展趋势。


## 解决方案

本平台经过调研选用 ant-design 为前端设计框架， 基于此挑选了其官方开源的脚手架 https://github.com/ant-design/ant-design-pro.git 
使用nodejs技术栈， 基于 ES2015+、React、dva、g2 和 antd进行前端快速构建与测试。

架构逻辑为:

用户 -> 前端管理界面(nodejs) -> 后端服务(restful api) -> 具体业务逻辑


基本模块为：

```
- Dashboard
  - 分析页
  - 监控页
  - 工作台
- 表单页
  - 基础表单页
  - 分步表单页
  - 高级表单页
- 列表页
  - 查询表格
  - 标准列表
  - 卡片列表
  - 搜索列表（项目/应用/文章）
- 详情页
  - 基础详情页
  - 高级详情页
- 结果
  - 成功页
  - 失败页
- 异常
  - 403 无权限
  - 404 找不到
  - 500 服务器出错
- 帐户
  - 登录
  - 注册
  - 注册成功
```

## 总结

1. 前后端分离的MVVM模式很好的分离了前后端，可以适配多种系统。
1. 模块化样式，可以很容易的复用。

## 可能的问题

1. 使用的是less，没有集成sass。
1. 学习难度也较一般的网页来的高。
1. es2015不如原生js调试方便。
1. 由于国内GFW问题，可以使用 https://cnpmjs.org/ 。但是还是有局限性，因为有些依赖包会从github上直接下载release导致速度特别慢。


