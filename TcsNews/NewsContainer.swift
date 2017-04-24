//
//  NewsContainer.swift
//  TcsNews
//
//  Created by Dmitry L on 22/04/2017.
//  Copyright © 2017 Dmitry L. All rights reserved.
//

import UIKit

class NewsContainer: NSObject
{
    var resultCode: String
    var payload:   [News]

    init(_ dictionary: NSDictionary)
    {
        self.resultCode = dictionary["resultCode"] as! String
        self.payload = []

        for newsItemDictionary in dictionary["payload"] as! Array<NSDictionary>
        {
            let news = News(newsItemDictionary)

            payload.append(news)
        }


    }
}
