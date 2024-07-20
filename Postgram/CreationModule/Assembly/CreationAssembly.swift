import Foundation
import UIKit

final class CreationAssembly {
    static func build(with imageData : Data) -> UIViewController {
        let router = Router()
        let model = CreationModel(imageData)
        
        let presenter = CreationPresenter(.init(router: router, model: model))
        
        let controller = CreationViewController(.init(presenter: presenter))
        let targetController = PublicationsAssembly.build()
        
        router.setUpCurrentController(with: controller)
        router.setUpTargetController(with: targetController)
        
        return controller
    }
}
