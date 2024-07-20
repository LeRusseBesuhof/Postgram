import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    // MARK: Singleton
    static let shared = CoreDataManager()
    
    private init() {
        TagTransformer.register()
        createRootFolder()
    }
    
    // MARK: private properties
    private var context : NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "post")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    private func saveContext () {
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
    
    // MARK: private properties
    private func fetchRootFolder() -> Publications? {
        let req = Publications.fetchRequest()
        do {
            let folders = try context.fetch(req)
            return folders.isEmpty ? nil : folders.first
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func createRootFolder() {
        let req = fetchRootFolder()
        if req == nil {
            let folder = Publications(context: context)
            folder.id = UUID().uuidString
            createTagsList(rootFolder: folder)
        }
        
        saveContext()
    }
    
    private func fetchTags() -> Tags? {
        guard let folder = fetchRootFolder() else { return nil }
        return folder.tags
    }
    
    // MARK: internal methods
    func fetchPosts() -> NSSet? {
        guard let folder = fetchRootFolder() else { return nil }
        return folder.publications
    }
    
    func createTagsList(rootFolder: Publications) {
        let tags = Tags(context: context)
        tags.id = UUID().uuidString
        tags.rootFolder = rootFolder
        tags.tagsData = []
        
        let tagNames = MockTagsData.getMockData()
        tagNames.forEach {
            let tag = Tag(id: UUID().uuidString, name: $0)
            tags.tagsData?.append(tag)
        }
        
        saveContext()
    }
    
    func createPost(with data: InputData) {
        guard let folder = fetchRootFolder() else { return }
        let post = Post(context: context)
        post.title = data.header
        post.date = data.date
        post.imageName = data.imageName
        post.text = data.text
        post.rootFolder = folder
        
        saveContext()
    }
}
