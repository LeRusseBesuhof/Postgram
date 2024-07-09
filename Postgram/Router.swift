import Foundation
import UIKit

final class Router {
    // MARK: private properties
    private var currentController : UIViewController?
    private var targetController : UIViewController?
    
    // MARK: internal methods
    func setUpCurrentController(with controller: UIViewController) {
        self.currentController = controller
    }
    
    func setUpTargetController(with controller: UIViewController) {
        self.targetController = controller
    }
    
    func pushTargetController() {
        NotificationCenter.default.post(name: .setRoot, object: targetController)
    }
}
