import Foundation
import UIKit

protocol PublicationsPresenterProtocol : AnyObject {
    func loadPresenter(view: PublicationsViewProtocol, controller: PublicationsViewControllerProtocol)
}

final class PublicationsPresenter {
    // MARK: private properties
    private let router : Router!
    private let model : PublicationsModelProtocol!
    private weak var view : PublicationsViewProtocol?
    private weak var controller : PublicationsViewControllerProtocol?
    private let coreDataManager = CoreDataManager.shared
    private let storageManager = StorageManager.shared
    
    // MARK: init
    struct Dependencies {
        let router : Router
        let model : PublicationsModelProtocol
    }
    
    init(_ dependencies: Dependencies) {
        self.router = dependencies.router
        self.model = dependencies.model
    }
    
    // MARK: private methods
    private func setupHandlers() {
        view?.createPost = { [weak self] in
            guard let self = self else { return }
            
            onCreatePostTouched()
        }
        
        view?.changePost = { [weak self] id in
            guard let self = self else { return }
            
            onChangePostTouched(by: id)
        }
        
        view?.deletePost = { [weak self] id in
            guard let self = self else { return }
            
            onDeletePostTouched(by: id)
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
    
    private func onChangePostTouched(by id: String) {
        
    }
    
    private func onDeletePostTouched(by id: String) {
        coreDataManager.deletePost(by: id)
        let indToRemove = model.deletePublicationDataBy(id)
        view?.publicationsMockData = model.getPublicationsData()
        view?.images.remove(at: indToRemove)
        view?.reloadCollectionComponents()
    }
    
    private func loadPublicationsData() {
        guard let publicationsSet = coreDataManager.fetchPublications() else {
            return
        }
        
        for pub in publicationsSet {
            let post = pub as! Post
            guard let imageData = storageManager.getImageData(byImageName: post.imageName!) else {
                return
            }
            guard let image = UIImage(data: imageData) else { return }
            view?.images.append(image)
            
            let publicationData = InputData(
                id: post.id!,
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
