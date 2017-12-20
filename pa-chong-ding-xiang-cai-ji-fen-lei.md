# 爬虫定向采集分类

通过对之前舆情,国网国际,国网内网等爬虫脚本进行分析.爬虫脚本有177个(不包括一些分页等等),
大致上分为以下几类.
1. 论坛
2. 表格
3. li包含a标签
4. div
5. 其他复杂特殊站点(包含登录,验证码等.)

其中表格类大约占45%,li中包含a标签占23%, div中包含a标签占16%,论坛和其他占16%.
使用webgather.py脚本针对表格和li类别测试,表格正确率70%,li正确率为50%.


1. 论坛
一般为 Discuz,使用通过 newspaper的库解析.

2. 表格
    * fjb_nea_gov_cn(权重判断错误): http://fjb.nea.gov.cn/news.aspx?id=54
    * fjjg_gov_cn(权重判断错误): * http://www.fjjg.gov.cn/fjwjj/jgzcfb/zcfgxx/A120205index_1.htm
    * fujian_gov_cn(buff判断错误): http://www.fujian.gov.cn/xw/fjyw
    * stats_fj_gov_cn(权重判断错误): http://www.stats-fj.gov.cn/xxgk/jdsj/
    * aer_gov_au(权重判断错误): https://www.aer.gov.au/news
    * fa_gai_wei: http://www.sdpc.gov.cn/xwzx/xwfb/
    * guo_wu_yuan: http://www.gov.cn/xinwen/index.htm
    * bjx_com_cn: http://shupeidian.bjx.com.cn/NewsList
    * cec_org_cn: http://www.cec.org.cn/yaowenkuaidi/
    * fjdpc_gov_cn: http://www.fjdrc.gov.cn/fgwgk/cszz/nyfzc2/nyxm/
    * fjetc_gov_cn: http://www.fjetc.gov.cn/zwgk/NewsList.aspx?columnID=13
    * fjic_gov_cn: http://www.fjic.gov.cn/xxgk/qkjb/mrrdxx/
    * nea_gov_cn: http://www.nea.gov.cn/news/jwzdt.htm
    * sdpc_gov_cn: http://www.ndrc.gov.cn/gzdt/
    * sgcio_com: http://www.sgcio.com/news/itsj/
    * stats_gov_cn: http://www.stats.gov.cn/tjsj/zxfb/
    * yejinzg: http://www.yejinzg.com/list/40.html
    * aemc_gov_au: http://www.aemc.gov.au/News-Center/What-s-New

3. li
    * zhong_ji_wei(权重判断错误): http://www.ccdi.gov.cn/yw/
    * chinapower(权重判断错误): http://www.chinapower.com.cn/focus/
    * customs_gov_cn(权重判断错误)* : http://www.customs.gov.cn/publish/portal123/tab63611/
    * escn_com_cn(权重判断错误): http://www.escn.com.cn/news/1.html
    * indaa_com_cn(多连接出错): http://www.indaa.com.cn/dwjs/
    * zui_gao_fa: http://www.court.gov.cn/zixun-gengduo-24.html
    * qq_browser_news: http://info.3g.qq.com/g/channel_tab.htm?* tabId=news_yaowen_tab&psize=30&pid=1
    * fj_xinhuanet_com: http://www.fj.xinhuanet.com/toutiao/index.htm
    * gov_cn: http://www.gov.cn/xinwen/yaowen.htm
    * milt: http://www.miit.gov.cn/n1146290/n1146402/n1146455/index.html

4. div
    * hotpoint_baidu: http://news.baidu.com/ns?tn=news&word=中国
    * yi_dian_zi_xun: http://www.yidianzixun.com/channel/hot
    * escn_com_cn: http://www.escn.com.cn/news/1.html
    * fj_people_com: http://fj.people.com.cn/GB/350390/350391/index.html
    * nandudu: http://www.nandudu.com/news
    * shanghai_guancha: http://www.shobserver.com/news/list?section=1
    * thepaper_cn: http://m.thepaper.cn/

5. 复杂 特殊
    * 微信
    * 新浪微博 
    * 微博qq 
    * weibo人民 
    * 100ppi(大宗商品) 
    * cqcoal(post)



