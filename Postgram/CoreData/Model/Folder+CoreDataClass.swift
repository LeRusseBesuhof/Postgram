import Foundation
import CoreData

@objc(Folder)
public class Folder: NSManagedObject {

}

extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var id: String?
    @NSManaged public var header: String?
    @NSManaged public var publications: NSSet?

}

extension Folder : Identifiable {

}
