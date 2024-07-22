import Foundation
import UIKit

// MARK: may be deleted

protocol PublicationsModelProtocol : AnyObject {
    func setPublicationData(_ data: InputData)
    func getPublicationsData() -> [InputData]
    func deletePublicationDataBy(_ id: String) -> Int
}

final class PublicationsModel {
    // MARK: private properties
    private var publications = [InputData]()
}

// MARK: internal properties
extension PublicationsModel : PublicationsModelProtocol {
    func setPublicationData(_ data: InputData) {
        publications.append(data)
    }
    
    func getPublicationsData() -> [InputData] {
        publications
    }
    
    func deletePublicationDataBy(_ id: String) -> Int {
        print("\n\(id)\n")
        var indToRemove = -1
        for ind in 0..<publications.count {
            print("\npub id \(publications[ind].id)\n")
            if publications[ind].id == id {
                publications.remove(at: ind)
                indToRemove = ind
                break
            }
        }
        print(publications)
        return indToRemove
    }
}
