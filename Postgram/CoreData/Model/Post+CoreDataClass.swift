import Foundation
import CoreData

@objc(Post)
public class Post: NSManagedObject {

}

extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var tags: [String]?
    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var rootFolder: Folder?

}

extension Post : Identifiable {

}
