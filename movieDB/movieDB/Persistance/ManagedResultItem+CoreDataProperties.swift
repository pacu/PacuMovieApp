//
//  ManagedResultItem+CoreDataProperties.swift
//  
//
//  Created by Francisco Gindre on 10/10/18.
//
//

import Foundation
import CoreData


extension ManagedResultItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedResultItem> {
        return NSFetchRequest<ManagedResultItem>(entityName: "ManagedResultItem")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var popularity: Float
    @NSManaged public var voteCount: Int
    @NSManaged public var firstAirDate: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var overview: String?
    @NSManaged public var adult: Bool
    @NSManaged public var video: Bool
    @NSManaged public var backdropPath: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var voteAverage: Float
    @NSManaged public var titile: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var locale: String?
    @NSManaged public var lastUpdated: NSDate?
    @NSManaged public var itemType: String?

}
