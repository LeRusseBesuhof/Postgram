import Foundation
import UIKit

final class CameraAssembly {
    static func build() -> UIViewController {
        let router = Router()
        let cameraService = CameraService()
        
        let presenter = CameraPresenter(.init(router: router, cameraService: cameraService))
        
        let controller = CameraViewController(.init(presenter: presenter))
        
        router.setUpCurrentController(with: controller)
        
        return controller
    }
}
