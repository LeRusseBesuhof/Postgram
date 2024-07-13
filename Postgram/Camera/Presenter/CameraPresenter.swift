import Foundation

protocol CameraPresenterProtocol : AnyObject {
    
}

final class CameraPresenter {
    // MARK: private properties
    private let cameraService : CameraServiceProtocol!
    private weak var controller : CameraViewControllerProtocol?
    
    // MARK: init
    struct Dependencies {
        let cameraService : CameraServiceProtocol
    }
    
    init(_ dependencies: Dependencies) {
        self.cameraService = dependencies.cameraService
    }
}

extension CameraPresenter : CameraPresenterProtocol {
    
}
