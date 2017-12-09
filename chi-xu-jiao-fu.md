
# 发现问题
在开发过程中经常会出现如下问题:
1. 需要提交部署包时,开发人员立即去编译,但是对编译的部署包未经过严格测试(质量没保障)
2. 在开发过程中,经常需要修改代码,但代码未及时做集成测试.
3. 静态代码检测
4. 缺少自动化测试,大部分只是单元测试.


# 解决方案
1. 需要引入持续集成机制,来保证实时程序的稳定和质量.
2. 及时测试发现程序中的bug
3. 

~~~
digraph graphname{

    User [label="User"]      // node T
    Ci [label="CI Server"]  // node P
    Repo [label="Repo"]
    Build_server [label="Build Server"]
    Test_server [label="Test Server"]

    User->Repo [label="check in", fontcolor=darkgreen] // edge T->P
    Repo->Ci [label="触发",fontcolor=darkgreen]
    Ci-> Build_server [label="build"]
    Build_server -> Ci [label="build result"]

    Ci -> Test_server [label="testing"]
    Test_server-> Ci [label="test result"]

    Ci -> User [label="通知结果"]

}
~~~

digraph g {

overlap=false;
rankdir = BT;
node [shape=record];
subgraph Atlantis {
	Tour;
	Order;
	CollectionPoint;
	TakePointTourist;
	TransportOwner;
	BusItem;
	ReturnPointTourist;

	Tour -> Order[label="" len=4.00];
	Order -> Tour[label="" len=4.00];
	CollectionPoint -> TakePointTourist[label="" len=4.00];
	TransportOwner -> BusItem[label="" len=4.00];
	CollectionPoint -> ReturnPointTourist[label="" len=4.00];
}
}


```
digraph g {

overlap=false;
rankdir = BT;
node [shape=record];
subgraph Atlantis {
	Tour;
	Order;
	CollectionPoint;
	TakePointTourist;
	TransportOwner;
	BusItem;
	ReturnPointTourist;

	Tour -> Order[label="" len=4.00];
	Order -> Tour[label="" len=4.00];
	CollectionPoint -> TakePointTourist[label="" len=4.00];
	TransportOwner -> BusItem[label="" len=4.00];
	CollectionPoint -> ReturnPointTourist[label="" len=4.00];
}
}
```