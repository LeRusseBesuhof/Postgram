import Foundation
import OrderedCollections

protocol CreationModelProtocol : AnyObject {
    var getImageData : Data { get }
}

final class CreationModel {
    // MARK: private properties
    private let imageData : Data
    
    // MARK: init
    init(_ imageData: Data) {
        self.imageData = imageData
    }
}

extension CreationModel : CreationModelProtocol {
    var getImageData : Data {
        get { imageData }
    }
    
}
