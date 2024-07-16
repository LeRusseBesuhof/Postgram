import Foundation
import CoreData

@objc(Publications)
public class Publications: NSManagedObject {

}

extension Publications {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Publications> {
        return NSFetchRequest<Publications>(entityName: "Publications")
    }

    @NSManaged public var id: String?
    @NSManaged public var publications: NSSet?
    @NSManaged public var tags: Tags?

}

extension Publications : Identifiable {

}
