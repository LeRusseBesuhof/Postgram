import Foundation
import UIKit

final class PublicationsAssembly {
    static func build() -> UIViewController {
        let model = PublicationsModel()
        let router = Router()
        let manager = CoreDataManager.shared
        manager.setUpRootFolder()
        
        let presenter = PublicationsPresenter(.init(router: router, model: model, manager: manager))
        
        let controller = PublicationsViewController(.init(presenter: presenter))
        let targerController = CameraAssembly.build()
        
        router.setUpCurrentController(with: controller)
        router.setUpTargetController(with: targerController)
        
        return controller
    }
}
