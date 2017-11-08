# gitbook 替代方案

## 问题
gitbook.com 在使用过程中,发现用户体验较不理想.
主要表现在:

1. gitbook.com web编辑器和gitbook editer编辑器同步经常不一致.
2. gitbook.com 打开较慢.

## 替代方案
经过实践测试,得出以下实践

1. 提供在实时在线预览功能(只读),**解决gitbook.com打开慢和同步问题**.
2. 可以在本地编辑器(例如 vi,sublime)中编辑文档,**最终提交文档,使团队协作编写文档无障碍.**
3. 可以在gitbook.com上阅读并编辑,能同步自动更新到github上,**并能导出pdf或者其他文档格式.**



## gitbook迁移方案
1. github.com上创建一个basinspace-gitbook项目,**迁移现有文档到github.com上( git 导入)**
2. 团队人员各自git clone basinspace-gitbook项目,使用习惯的编辑器进行文档编辑**(解决依赖gitbook.com在线编辑或者gitbook editer编辑)**
3. gitbook提供了与github无缝导入功能.**能导入现有文档(解决导出pdf,其他文档格式)**
4. 在公网阿里云机器或者公司gpu服务器上搭建gitbook docker 服务,拉取最新文档内容并展示**(解决gitbook.com打开慢)**

## 存在问题
1. basinspace-gitbook 在github.com上项目开源.


## 备选
1. 也可以迁移到新搭建的gitlab上,但是gitbook暂时无法和gitlab对接. 搭建gitbook服务自带导出pdf功能.没有gitbook.com上导出pdf功能效果好.
