# Intro
----

项目路径：/bidspy/src/extractor/

- basin-textminer: 文本处理，语料库表达。内含多个小project，如招标公告提取
- annotator-server: 招标公告提取分析接口， annotator接口， crf训练接口等


接口调用方式详见: annotator-server/README.md

## 接口

注:

- 所有接口只有http code 为 200时 返回为成功
- 出错返回500，具体出错原因写在 response body 里


### 招标公告信息单条提取接口

- URL:/bid/info/extract/single
- Type:JSON
- HTTP Method:POST
- Parameters:

    |name | required | type and range | info |
    | --- | ---- | --- | --- |
    | html | true | string | 招标公告正文部分的html |
    | text | optional | string | 注意，必须传 html 或者text 之一 |
    | title | false | string | 招标公告 |
    | url | false | string | 结束时间 |

- Parameters Example:

        {
            'html': 'xxx',
            'title': 'xxx',
            'url': 'xxx',
        }

- Result Example:
    
        {
            'public_date':'发布日期',
            'end_date':'截止日期',
            'open_date':'开标日期',
            'win_date':'中标日期',
            'file_date':'文件获取日期',
            'budget_price':'预算金额',
            'deal_price':'成交金额',
            'buy_price':'采购金额',
            'open_price':'开标金额',
            'win_price':'中标金额',
            'enter_price':'入围金额',
            'project':'项目',
            'proxy':'代理机构',
            'proxy_address':'代理机构地址',
            'proxy_telephone':'代理机构电话',
            'proxy_contacter':'代理机构联系人',
            'proxy_contacter_phone':'代理机构联系人手机',
            'proxy_contacter_email':'代理机构联系人邮箱',
            'buyer':'采购机构',
            'buyer_address':'采购机构地址',
            'buyer_telephone':'采购机构电话',
            'buyer_contacter':'采购机构联系人',
            'buyer_contacter_phone':'采购机构联系人手机',
            'buyer_contacter_email':'采购机构联系人邮箱',
            'file_mail_address':'投标文件递交地址',
            'qualification':'资质',
            'province':'省',
            'city':'市',
            'area':'区',
            'bid_type':'招标类型',
            'title_type':'公告类型',
            'registered_in_china':'境内注册',
            'allow_union':'接受联合体投标',
            'bid_number':'项目(招标)编号',
            'service_provider':'招标服务单位',
            'committee':'评标委员会',
            'bid_method':'招标方式',
            'buy_method':'采购方式',
            'duration':'工期',
        }
    

### 招标公告信息批量提取接口(支持异步调用时需要id)

- URL:/bid/info/extract
- Type:JSON
- HTTP Method:POST
- Parameters:

    list of item, each item:

    |name | required | type and range | info |
    | --- | ---- | --- | --- |
    | id   | true | string | 文章id |
    | html | true | string | 招标公告正文部分的html |
    | text | optional | string | 注意，必须传 html 或者text 之一 |
    | title | false | string | 招标公告 |
    | url | false | string | 结束时间 |

- Parameters Example:
    
        [
            {
                'id': 1,
                'html': 'xxx',
                'title': 'xxx',
                'url': 'xxx',
            },
            ...
        ]
    

- Result Example:
    
        [
            {
                'id': 1,
                'info': {
                    'public_date':'发布日期',
                    'end_date':'截止日期',
                    'open_date':'开标日期',
                    'win_date':'中标日期',
                    'file_date':'文件获取日期',
                    'budget_price':'预算金额',
                    'deal_price':'成交金额',
                    'buy_price':'采购金额',
                    'open_price':'开标金额',
                    'win_price':'中标金额',
                    'enter_price':'入围金额',
                    'project':'项目',
                    'proxy':'代理机构',
                    'proxy_address':'代理机构地址',
                    'proxy_telephone':'代理机构电话',
                    'proxy_contacter':'代理机构联系人',
                    'proxy_contacter_phone':'代理机构联系人手机',
                    'proxy_contacter_email':'代理机构联系人邮箱',
                    'buyer':'采购机构',
                    'buyer_address':'采购机构地址',
                    'buyer_telephone':'采购机构电话',
                    'buyer_contacter':'采购机构联系人',
                    'buyer_contacter_phone':'采购机构联系人手机',
                    'buyer_contacter_email':'采购机构联系人邮箱',
                    'file_mail_address':'投标文件递交地址',
                    'qualification':'资质',
                    'province':'省',
                    'city':'市',
                    'area':'区',
                    'bid_type':'招标类型',
                    'title_type':'公告类型',
                    'registered_in_china':'境内注册',
                    'allow_union':'接受联合体投标',
                    'bid_number':'项目(招标)编号',
                    'service_provider':'招标服务单位',
                    'committee':'评标委员会',
                    'bid_method':'招标方式',
                    'buy_method':'采购方式',
                    'duration':'工期',
                }
            },
            ...
        ]
    
    
### 招标公告关注预测，批量分析接口

- URL:/bid/predict/concern
- Type:JSON
- HTTP Method:POST
- Parameters:

    |name | required | type and range | info |
    | --- | ---- | --- | --- |
    | id | true | string | 原始id |
    | title | true | string | 标题 |
    | content | true | string | 正文 |

- Parameters Example:
    
            [
                {
                    'id': id,
                    'title': title,
                    'content': content,
                },
                ...
            ]
    
- Return Value:
    
            [
                {
                    'id': id,
                    'result': 0,
                },
                {
                    'id': id,
                    'result': 1,
                },
                {
                    'id': id,
                    'result': 99,
                },
                ...
            ]
    

### 招标公告关注预测，单条分析接口

- URL:/bid/predict/concern/single
- Type:JSON
- HTTP Method:POST
- Parameters:

    |name | required | type and range | info |
    | --- | ---- | --- | --- |
    | title | true | string | 标题 |
    | content | true | string | 正文 |

- Parameters Example:

        {
            'title': title,
            'content': content,
        }


- Return Value:

        {
            'result': 0,
        }
