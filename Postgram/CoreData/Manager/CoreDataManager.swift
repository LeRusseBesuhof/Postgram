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
    func fetchRootFolder() -> Folder? {
        let req = Folder.fetchRequest()
        do {
            let folders = try context.fetch(req)
            return folders[0]
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func setUpRootFolder() {
        if let folder = fetchRootFolder() {
            self.rootFolder = folder
        } else {
            guard let folderDescription = NSEntityDescription.entity(forEntityName: "Folder", in: context) else {
                print("an error")
                return
            }
            let folder = Folder(entity: folderDescription, insertInto: context)
            // let folder = Folder(context: context)
            folder.id = UUID().uuidString
            folder.header = "Publications"
            self.rootFolder = folder
            
            print(FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first)
        }
        
        saveContext()
    }
    
    func createFolder() {
        guard let folderDescription = NSEntityDescription.entity(forEntityName: "Folder", in: context) else {
            print("an error")
            return
        }
        let folder = Folder(entity: folderDescription, insertInto: context)
        // let folder = Folder(context: context)
        folder.id = "123"
    }
}
