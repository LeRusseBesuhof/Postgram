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
    
    // MARK: private methods
    private func setupHandlers() {
        view?.createPost = { [weak self] in
            guard let self = self else { return }
            
            onCreatePostTouched()
        }
    }
    
    private func setupPublications() {
        loadPublicationsData()
        view?.publicationsMockData = model.getPublicationsData()
        view?.reloadCollectionComponents()
    }
}

private extension PublicationsPresenter {
    
    private func onCreatePostTouched() {
        router.pushTargetController()
    }
    
    private func loadPublicationsData() {
        guard let publicationsSet = CoreDataManager.shared.fetchPosts() else {
            print("Something went wrong with publications access")
            return
        }
        
        for pub in publicationsSet {
            let post = pub as! Post
            guard let imageData = StorageManager.shared.getImageData(byImageName: post.imageName!) else {
                print("Something went wrong with image data loading")
                return
            }
            guard let image = UIImage(data: imageData) else {
                print("Something went wrong with image conversion")
                return
            }
            view?.images.append(image)
            
            let publicationData = InputData(
                header: post.title!,
                date: post.date!,
                text: post.text!,
                imageName: post.imageName!
            )
            
            model.setPublicationData(publicationData)
        }
    }
}

// MARK: protocol methods
extension PublicationsPresenter : PublicationsPresenterProtocol {
    func loadPresenter(view: PublicationsViewProtocol, controller: PublicationsViewControllerProtocol) {
        self.view = view
        self.controller = controller
        
        self.setupHandlers()
        self.setupPublications()
    }
}
