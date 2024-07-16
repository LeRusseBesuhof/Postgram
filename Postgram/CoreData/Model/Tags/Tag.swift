import Foundation

final public class Tag : NSObject, Codable {
    private var id : String
    private var name : String
    private var postIDs : Set<String>
    
    init(id: String, name: String, postIDs: Set<String> = []) {
        self.id = id
        self.name = name
        self.postIDs = postIDs
    }
    
    func getName() -> String { name }
    
    func getPostIDs() -> Set<String> { postIDs }
    
    func addPostID(_ id: String) {
        postIDs.insert(id)
    }
    
    func removePostID(_ id: String) {
        postIDs.remove(id)
    }
}
