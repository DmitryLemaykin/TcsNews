//
//  CoreDataManager+News.swift
//  TcsNews
//
//  Created by Dmitry L on 23/04/2017.
//  Copyright © 2017 Dmitry L. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataManager
{
    public func getNewsSortedByDate() -> [News]
    {
        let newsEntitisFetchRequest:NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        newsEntitisFetchRequest.sortDescriptors = [NSSortDescriptor(key: "publicationDate", ascending: false)]

        var news = [News]()
        do
        {
            let searchResults = try self.managedObjectContext.fetch(newsEntitisFetchRequest)

            // Do not loos order
            for (_, searchResult) in (searchResults as [NewsEntity]).enumerated()
            {
                let tempNews = News(searchResult)
                news.append(tempNews)
            }


        }
        catch
        {
            print("Error: getNewsSortedByDate: \(error)")
        }

        return news
    }

    public func getDetailsById(_ id:String) -> Details?
    {
        let fetchRequest:NSFetchRequest<DetailsEntity> = DetailsEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        do
        {
            let searchResults = try self.managedObjectContext.fetch(fetchRequest)

            if searchResults.count > 0
            {
                return Details(searchResults.first!)
            }
            else
            {
                return nil
            }
        }
        catch
        {
            print("Error: getNewsSortedByDate: \(error)")
        }
        
        return nil
    }

}
