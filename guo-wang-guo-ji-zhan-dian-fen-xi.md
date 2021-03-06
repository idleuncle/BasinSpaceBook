# 国网国际站点分析

## 现状

国网国际站点,目前共573个网站,其中分析100个网站,基本上属于div模型,即div中包含url连接,由于div的样子种类很多,多种div混合嵌套等.爬虫模板的目标自动分析出div列表页的url地址,并进行详细内容采集.

## 分析方法
1. 分析网页模型,看是否有通用的网页模板.  
    测试结果:经过分析发现.网站没有特定规律,能够适配的网页模板很少,此方法暂时放弃.

2. 由于div嵌套关系,抽象成多叉树, 遍历树中div包含最大url总数,最大a标签总数的div,作为最有可能的div,并在此基础上加上div总字符集等作为辅助加分项, 取最后div列表页
    测试结果: 在测试中,发现有的div中只包含1个url连接,由这种类型div构成'大'的div列表页,再统计url总数, 但有可能大div还包含了其他url连接, 最终多个'大'的div在做对比的时候.就容易出现分析得出错误的url地址.

3. 根据之前编写爬虫经验,大部分是在圈定的div中遍历列表页,圈定的方法:很多时候依据css样式来定位, 在定位的过程.大部分css关键字诸如 "news, content, group,container'等,所以圈定大的div,在从中遍历a标签, 此过程中有可能会得到较多无用的url,后期再加上一些反策略的判断,例如title长度小于5等能过滤一些无用url,随着反策略方法的增加,能够获得较为准确的url列表页.
    接错结果:在国网国际的网站中.采用90个站点做测试,准确率为40%, 其中有9个是网站无法访问,3个是table页面,剩余的站点还未详细分析.大致分析大部分属于div类型.

## 下一步工作
1. 爬虫通用模板分两类,1类使用table/list分类,1类使用div分类,在此基础上,增加反策略和css定位判断,提高准确率.
2. 完善爬虫测试框架,针对新增的css定位,对旧素材站点做遍历测试,减少误判断.
