import Foundation
import UIKit

// MARK: may be deleted

protocol PublicationsModelProtocol : AnyObject {
    func setPublicationData(_ data: InputData)
    func getPublicationsData() -> [InputData]
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
}
