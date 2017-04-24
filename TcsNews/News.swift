//
//  News.swift
//  TcsNews
//
//  Created by Dmitry L on 22/04/2017.
//  Copyright © 2017 Dmitry L. All rights reserved.
//

import UIKit

class News
{
    let id             : String
    let name           : String
    let text           : String
    let bankInfoTypeId : Int16
    let publicationDate: NSDate

    static private let ID_KEY               = "id"
    static private let NAME_KEY             = "name"
    static private let TEXT_KEY             = "text"
    static private let TYPE_ID_KEY          = "bankInfoTypeId"
    static private let PUBLICATION_DATE_KEY = "publicationDate.milliseconds"

    init(_ newsEntity: NewsEntity)
    {
        self.id              = newsEntity.id!
        self.name            = newsEntity.name!
        self.text            = newsEntity.text!
        self.bankInfoTypeId  = newsEntity.bankInfoTypeId
        self.publicationDate = newsEntity.publicationDate!
    }

    init(_ dictionary: NSDictionary)
    {
        self.id             = dictionary[News.ID_KEY] as! String
        self.name           = dictionary[News.NAME_KEY] as! String
        self.text           = dictionary[News.TEXT_KEY] as! String
        self.bankInfoTypeId = Int16(dictionary[News.TYPE_ID_KEY] as! NSNumber)
        self.publicationDate = NSDate(timeIntervalSince1970: TimeInterval(dictionary.value(forKeyPath: News.PUBLICATION_DATE_KEY) as! NSNumber) / 1000)
    }

//    "id": "8165",
//    "name": "21042017-tinkoff-successfully-places-ruble-bond-eng",
//    "text": "Tinkoff Bank successfully places RUB 5 bn&nbsp;bond with a&nbsp;coupon of&nbsp;9.65%",
//    "publicationDate": {
//				"milliseconds": 1492797691000
//    },
//    "bankInfoTypeId": 1
}
