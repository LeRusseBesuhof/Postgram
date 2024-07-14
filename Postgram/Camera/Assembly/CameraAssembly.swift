import Foundation
import UIKit

final class CameraAssembly {
    static func build() -> UIViewController {
        let cameraService = CameraService()
        let presenter = CameraPresenter(.init(cameraService: cameraService))
        
        let controller = CameraViewController(.init(presenter: presenter))
        
        return controller
    }
}
