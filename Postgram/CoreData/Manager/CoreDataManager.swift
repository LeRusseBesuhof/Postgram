import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    // MARK: Singleton
    static let shared = CoreDataManager()
    var rootFolder : Folder?
    private init() { }
    
    // MARK: private properties
    private var context : NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "post")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: internal methods
    func fetchRootFolder() -> [Folder]? {
        let req = Folder.fetchRequest()
        do {
            let folders = try context.fetch(req)
            return folders
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func setUpRootFolder() {
        if let folders = fetchRootFolder(), !folders.isEmpty {
            self.rootFolder = folders[0]
        } else {
            let folder = Folder(context: context)
            folder.id = UUID().uuidString
            folder.header = "Publications"
            self.rootFolder = folder
            
        }
        
        saveContext()
    }
}
