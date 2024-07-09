import Foundation
import UIKit

protocol PublicationsPresenterProtocol : AnyObject {
    func loadPresenter(view: PublicationsViewProtocol, controller: PublicationsViewControllerProtocol)
}

final class PublicationsPresenter {
    // MARK: private properties
    private var router : Router!
    private var model : PublicationsModelProtocol!
    private var storageManager : CoreDataManager!
    private weak var view : PublicationsViewProtocol?
    private weak var controller : PublicationsViewControllerProtocol?
    
    // MARK: init
    struct Dependencies {
        let router : Router
        let model : PublicationsModelProtocol
        let manager : CoreDataManager
    }
    
    init(_ dependencies: Dependencies) {
        self.router = dependencies.router
        self.model = dependencies.model
        self.storageManager = dependencies.manager
    }
}

// MARK: private methods
private extension PublicationsPresenter {
    private func setUpHandlers() {
        
    }
}

// MARK: protocol methods
extension PublicationsPresenter : PublicationsPresenterProtocol {
    func loadPresenter(view: PublicationsViewProtocol, controller: PublicationsViewControllerProtocol) {
        self.view = view
        self.controller = controller
        
        self.setUpHandlers()
    }
}
