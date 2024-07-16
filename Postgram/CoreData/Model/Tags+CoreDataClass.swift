import Foundation
import CoreData

@objc(Tags)
public class Tags: NSManagedObject {

}

extension Tags {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tags> {
        return NSFetchRequest<Tags>(entityName: "Tags")
    }

    @NSManaged public var id: String?
    @NSManaged public var tagsData: [Tag]?
    @NSManaged public var rootFolder: Publications?

}

extension Tags : Identifiable {

}
