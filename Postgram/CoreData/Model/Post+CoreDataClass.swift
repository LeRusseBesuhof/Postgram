//
//  Post+CoreDataClass.swift
//  Postgram
//
//  Created by Павел Градов on 15.07.2024.
//
//

import Foundation
import CoreData

@objc(Post)
public class Post: NSManagedObject {

}

extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var tagsIDs: [String]?
    @NSManaged public var text: String?
    @NSManaged public var title: String?
    @NSManaged public var rootFolder: Publications?

}

extension Post : Identifiable {

}
