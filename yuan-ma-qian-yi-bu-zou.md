# 源码迁移

## 问题
当前源码保存在10.142.55.199上,由于团队协作,设计到提交权限不足,不得不每次修改提交到仓库中文件的权限,故迁移当前源码到内网gitlab上.


## 迁移步骤
1. 注册地址: http://10.142.55.199:50080/
需要加入到basinspace组中(@chenqian,@chenyuyan)来加入,最好加入sshkey到gitlab中.

2. git pull ssh://git@10.142.55.199:10022/basinspace/bidspy.git

或修改代码中.git/config的地址.修改成最新的地址.在git pull