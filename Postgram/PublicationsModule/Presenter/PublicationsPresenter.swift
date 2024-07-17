import Foundation
import UIKit

protocol PublicationsPresenterProtocol : AnyObject {
    func loadPresenter(view: PublicationsViewProtocol, controller: PublicationsViewControllerProtocol)
}

final class PublicationsPresenter {
    // MARK: private properties
    private let router : Router!
    private let model : PublicationsModelProtocol!
    // private let storageManager : CoreDataManager!
    private weak var view : PublicationsViewProtocol?
    private weak var controller : PublicationsViewControllerProtocol?
    
    // MARK: init
    struct Dependencies {
        let router : Router
        let model : PublicationsModelProtocol
        // let manager : CoreDataManager
    }
    
    init(_ dependencies: Dependencies) {
        self.router = dependencies.router
        self.model = dependencies.model
        // self.storageManager = dependencies.manager
    }
}

// MARK: private methods
private extension PublicationsPresenter {
    private func onCreatePostTouched() {
        router.pushTargetController()
    }
    
    private func setUpHandlers() {
        view?.createPost = { [weak self] in
            guard let self = self else { return }
            
            onCreatePostTouched()
        }
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
