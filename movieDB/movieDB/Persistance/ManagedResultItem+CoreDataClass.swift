//
//  ManagedResultItem+CoreDataClass.swift
//  
//
//  Created by Francisco Gindre on 10/10/18.
//
//

import Foundation
import CoreData

@objc(ManagedResultItem)
public class ManagedResultItem: NSManagedObject {
    
}


extension ManagedResultItem {
    var resultItem: ResultItem {
       return ResultItem(managedObject: self)
        
    }
}

private extension ResultItem {
    init(managedObject: ManagedResultItem) {
        self.adult = managedObject.adult
        self.firstAirDate = managedObject.firstAirDate
        self.id = Int(truncatingIfNeeded: managedObject.id)
        self.name = managedObject.name
        self.originalLanguage = managedObject.name
        self.originalTitle = managedObject.originalTitle
        self.overview = managedObject.overview
        self.popularity = managedObject.popularity
        self.posterPath = managedObject.posterPath
        self.releaseDate = managedObject.releaseDate
        self.title = managedObject.titile
        self.video = managedObject.video
        self.voteAverage = managedObject.voteAverage
        self.voteCount = managedObject.voteCount
        self.genreIds = nil
        
    }
}


protocol ManagedConvertible {
    func managedObject(inContext: NSManagedObjectContext) -> NSManagedObject
}

class DataPersistance<T> {
    
    
    static func store(items: [ManagedConvertible], completionBlock: (_ error: NSError?)-> Void) {
        
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = AppDelegate.shared.currentContext
        
        context.perform {
            
            items.map{ $0.managedObject(inContext: context) }
        }
    }
}
