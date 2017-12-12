# spider 源码说明
## 目录结构

+ basin-spider  
    + basinspider 提供basin-api接口,用于应用系统调用爬虫服务
+ udb-spider 
    + 基于pyspider 二次开发.

## 技术架构

![](/assets/spider.png)


~~~
digraph graphname{

    basin_spider_api [label="basin_spider_api"]      // node T
    pyspider_webui [label="pyspider_webui"]  // node P
    pyspider_redis [label="pyspider_redis"]
    pyspider_scheduler  [label="pyspider_scheduler"]
    pyspider_fetcher [label="pyspider_fetcher"]
    pyspider_processer [label="pyspider_processer"]
    pyspider_result_worker [label="pyspider_result_worker"]
    DB [label="database"]

    basin_spider_api->pyspider_webui
    pyspider_webui -> DB
    pyspider_scheduler->pyspider_redis
    pyspider_fetcher -> pyspider_redis
    pyspider_processer-> pyspider_redis
    pyspider_result_worker ->pyspider_redis
    pyspider_webui  ->pyspider_redis
    pyspider_result_worker ->DB
    pyspider_scheduler->DB
    basin_spider_api->DB


}

~~~

![](/graphics/spider_tech_arch.png)