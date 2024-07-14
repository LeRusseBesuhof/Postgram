import Foundation
import UIKit

protocol CreationPresenterProtocol : AnyObject {
    func loadPresenter(with view: CreationViewProtocol, controller: CreationViewControllerProtocol)
}

final class CreationPresenter {
    // MARK: private properties
    private let router : Router!
    private let model : CreationModelProtocol!
    private weak var view : CreationViewProtocol?
    private weak var controller : CreationViewControllerProtocol?
    
    // MARK: init
    struct Dependencies {
        let router : Router
        let model : CreationModelProtocol
    }
    
    init(_ dependencies: Dependencies) {
        self.router = dependencies.router
        self.model = dependencies.model
    }
}

// MARK: private methods
private extension CreationPresenter {
    private func setUpHandlers() {
        
    }
    
    private func setCapturedImageToView() {
        let imageData = model.getImageData
        guard let image = UIImage(data: imageData) else {
            print("Convertion from Data to UIImage went wrong")
            return
        }
        view?.setCapturedImage(image)
    }
}

// MARK: internal methods
extension CreationPresenter : CreationPresenterProtocol {
    func loadPresenter(with view: CreationViewProtocol, controller: CreationViewControllerProtocol) {
        self.view = view
        self.controller =  controller
        
        setCapturedImageToView()
        self.setUpHandlers()
    }
}
