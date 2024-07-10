import Foundation
import UIKit

final class CreationAssembly {
    static func build() -> UIViewController {
        let router = Router()
        let model = CreationModel()
        
        let presenter = CreationPresenter(.init(router: router, model: model))
        
        let controller = CreationViewController(.init(presenter: presenter))
        
        router.setUpCurrentController(with: controller)
        
        return controller
    }
}
