//
//  TcsServiceManager.swift
//  TcsNews
//
//  Created by Dmitry L on 22/04/2017.
//  Copyright © 2017 Dmitry L. All rights reserved.
//

import UIKit
import CoreData

class TcsServiceManager
{
    // Singletone
    static let sharedInstance =
    {
        TcsServiceManager()
    }()

    static public let dataLoadedNotificationName = Notification.Name("DataLoadedNotificationName")
    static private let serialQueue = DispatchQueue(label: "tcsServiceSerialQueue")
    static private let newsUrl = URL(string:"https://api.tinkoff.ru/v1/news")!

    static let newsEntityClassName     = String(describing: NewsEntity.self)
    static let detailesEntityClassName = String(describing: DetailsEntity.self)

    public func getNews(callBackClosure:@escaping ([News]) -> Void)
    {
        TcsServiceManager.serialQueue.async
        {
            let cachedNews = CoreDataManager.sharedInstance.getNewsSortedByDate()

            if cachedNews.count > 0
            {
                callBackClosure(cachedNews)
                return
            }

            do
            {
                let data = try Data(contentsOf: TcsServiceManager.newsUrl)

                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())

                let newsContainer = NewsContainer(json as! NSDictionary)

                if newsContainer.resultCode != "OK"
                {

                }
                //NotificationCenter.default.post(name:TcsServiceManager.dataLoadedNotificationName, object:["news" : newsContainer.payload])

                let convertedString = NSString(data:data, encoding:String.Encoding.utf8.rawValue)
                print(convertedString ?? "No response string")

                let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
                for news in newsContainer.payload
                {
                    let entity = NSEntityDescription.entity(forEntityName: TcsServiceManager.newsEntityClassName, in: managedObjectContext)
                    let newsEntity = NSManagedObject(entity: entity!, insertInto: managedObjectContext) as! NewsEntity

                    newsEntity.id   = news.id
                    newsEntity.name = news.name
                    newsEntity.text = news.text
                    newsEntity.bankInfoTypeId = Int16(news.bankInfoTypeId)
                    newsEntity.publicationDate = news.publicationDate as NSDate
                }
                CoreDataManager.sharedInstance.saveContext()

                newsContainer.payload.sort { $0.publicationDate.timeIntervalSince1970 > $1.publicationDate.timeIntervalSince1970 }

                callBackClosure(newsContainer.payload)
            }
            catch
            {
                print("Error while getting data from: \(TcsServiceManager.newsUrl) error: \(error)")

                // MARK: Alternative way via Notifications
                // NotificationCenter.default.post(name:TcsServiceManager.dataLoadedNotificationName, object:error)
                callBackClosure([News]())
            }
        }
    }

    public func getContentFor(_ payloadId: String, callBackClosure:@escaping (Details?) -> Void)
    {
        TcsServiceManager.serialQueue.async
        {
            let cachedDetailes = CoreDataManager.sharedInstance.getDetailsById(payloadId)

            if (cachedDetailes != nil)
            {
                callBackClosure(cachedDetailes)
                return
            }

            do
            {
                let contentUrl = URL(string: "https://api.tinkoff.ru/v1/news_content?id=\(payloadId)")!
                let data = try Data(contentsOf: contentUrl)

                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())

                let detailes = Details(json as! NSDictionary)

                let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
                let entity = NSEntityDescription.entity(forEntityName: TcsServiceManager.detailesEntityClassName, in: managedObjectContext)
                let detailesEntity = NSManagedObject(entity: entity!, insertInto: managedObjectContext) as! DetailsEntity

                detailesEntity.id    = detailes.id
                detailesEntity.title = detailes.title
                detailesEntity.content = detailes.content

                CoreDataManager.sharedInstance.saveContext()

                callBackClosure(detailes)
            }
            catch
            {
                print("Error while getting data from: \(TcsServiceManager.newsUrl) error: \(error)")

                callBackClosure(nil)
            }
        }
    }
}
