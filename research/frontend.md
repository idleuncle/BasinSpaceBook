# ant-design

## 官方脚手架

https://github.com/ant-design/ant-design-pro

## 文档

https://pro.ant.design/docs/getting-started-cn

## 前序准备

你的本地环境需要安装 node(6.5+) 和 git。我们的技术栈基于 ES2015+、React、dva、g2 和 antd，提前了解和学习这些知识会非常有帮助。


## 模板

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

## 使用

```bash
$ git clone https://github.com/ant-design/ant-design-pro.git --depth=1
$ cd ant-design-pro
$ npm install
$ npm start         # 访问 http://localhost:8000
```

也可以使用集成化的 [ant-design-pro-cli](https://github.com/ant-design/ant-design-pro-cli) 工具。

```bash
$ npm install ant-design-pro-cli -g
$ mkdir pro-demo && cd pro-demo
$ pro new
```

更多信息请参考 [使用文档](http://pro.ant.design/docs/getting-started)。

注意：由于国内GFW问题，可以使用 https://cnpmjs.org/ 。但是还是有局限性，因为有些依赖包会从github上直接下载release导致速度特别慢。

## 兼容性

现代浏览器及 IE11。
