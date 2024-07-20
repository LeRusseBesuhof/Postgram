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
        view?.createPost = { [weak self] in
            guard let self = self else { return }
            
            onCreatePostTouched()
        }
    }
    
    private func setCapturedImageToView() {
        let imageData = model.getImageData
        guard let image = UIImage(data: imageData) else {
            print("Convertion from Data to UIImage went wrong")
            return
        }
        view?.setCapturedImage(image)
    }
    
    private func onCreatePostTouched() {
        guard let inputData = view?.getInputData() else { print("no input data"); return }
        let image = view!.getImage()
        saveImage(image, imageName: inputData.imageName)
        
        CoreDataManager.shared.createPost(with: inputData)
        router.pushTargetController()
    }
    
    private func saveImage(_ image: UIImage, imageName: String) {
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            print("Something went wrong with jpeg compression")
            return
        }
        
        StorageManager.shared.saveImageData(imageData, imageName)
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
