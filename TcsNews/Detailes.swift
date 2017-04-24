//
//  Detailes.swift
//  TcsNews
//
//  Created by Dmitry L on 24/04/2017.
//  Copyright © 2017 Dmitry L. All rights reserved.
//

import Foundation

class Details
{
    let id      : String
    let title   : String
    let content : String

    static private let ID_KEY_PATH      = "payload.title.id"
    static private let TITLE_KEY_PATH   = "payload.title.text"
    static private let CONTENT_KEY_PATH = "payload.content"

//    init(_ newsEntity: NewsEntity)
//    {
//        self.resultCode      = newsEntity.id!
//        self.name            = newsEntity.name!
//        self.text            = newsEntity.text!
//        self.bankInfoTypeId  = newsEntity.bankInfoTypeId
//        self.publicationDate = newsEntity.publicationDate!
//    }

    init(_ dictionary: NSDictionary)
    {
        self.id      = dictionary.value(forKeyPath:Details.ID_KEY_PATH) as! String
        self.title   = dictionary.value(forKeyPath:Details.TITLE_KEY_PATH) as! String
        self.content = dictionary.value(forKeyPath:Details.CONTENT_KEY_PATH) as! String
    }

    init(_ entity: DetailsEntity)
    {
        self.id      = entity.id!
        self.title   = entity.title!
        self.content = entity.content!
    }

}

//{
//    "resultCode": "OK",
//    "payload": {
//        "title": {
//            "id": "8165",
//            "name": "21042017-tinkoff-successfully-places-ruble-bond-eng",
//            "text": "Tinkoff Bank successfully places RUB 5 bn&nbsp;bond with a&nbsp;coupon of&nbsp;9.65%",
//            "publicationDate": {
//                "milliseconds": 1492797691000
//            },
//            "bankInfoTypeId": 1
//        },
//        "creationDate": {
//            "milliseconds": 1492787230000
//        },
//        "lastModificationDate": {
//            "milliseconds": 1492787230000
//        },
//        "content": "<p>Moscow, Russia&nbsp;&mdash; 21 April 2017. <br />\n\tTCS Group Holding PLC (TCS LI) (the ‘Group’), Russia&rsquo;s leading provider of&nbsp;online retail financial services, including Tinkoff Bank and Tinkoff Insurance, today announces the successful placement of&nbsp;Tinkoff Bank’s&nbsp;<nobr>001Р-01R</nobr> series exchange bonds for a&nbsp;total nominal value of&nbsp;RUB 5 bn&nbsp;at&nbsp;a&nbsp;final coupon rate of&nbsp;9.65% per annum.</p>\n\n<p>The bonds have a&nbsp;maturity period of&nbsp;five years with a&nbsp;<nobr>two-year</nobr> put option from placement. The offering is&nbsp;part of&nbsp;Tinkoff Bank’s&nbsp;001Р series exchange bond programme from 24 March 2017, totalling RUB 100 bn.</p>\n\n<p>Tinkoff Bank plans to&nbsp;use the proceeds of&nbsp;the bond issue for the development of&nbsp;new business lines.</p>\n\n<p>The initial guidance for the annual coupon rate was set within 9.75&ndash;10%. Following strong investor demand resulted in&nbsp;the offering being well oversubscribed, the first four coupon rates were fixed at&nbsp;(9.65%), lower than the initial guidance.</p>\n\n<p>Sergey Pirogov, Vice President for Corporate Finance at&nbsp;Tinkoff Bank, said: &laquo;We&nbsp;are happy with the offering outcome. We&nbsp;came up&nbsp;with a&nbsp;good order book and achieved significant decrease in&nbsp;the offer price compared to&nbsp;the initial guidance. Russia&rsquo;s bond market becomes an&nbsp;attractive source of&nbsp;the rouble liquidity again.&raquo;</p>\n\n<p>The offering was arranged by&nbsp;Sberbank CIB and Sovcombank.</p>\n\n<p>The bonds will be&nbsp;placed at&nbsp;the Moscow Exchange on&nbsp;28 April 2017.</p>",
//        "bankInfoTypeId": 1,
//        "typeId": "usual"
//    }
//}
