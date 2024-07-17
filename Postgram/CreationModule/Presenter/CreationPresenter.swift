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
        guard var inputData = view?.getInputData() else { print("no input data"); return }
        
        let imageData = inputData.imageData
        guard let imageURL = saveImage(imageData, to: UUID().uuidString) else { print("error"); return }
        inputData.imageURL = imageURL
        
        CoreDataManager.shared.createPost(with: inputData)
    }
    
    private func saveImage(_ imageData: Data, to filename: String) -> URL? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = documentsDirectory.first?.appendingPathComponent(filename)
        if let URI = fileURL {
            do {
                try imageData.write(to: URI)
            } catch {
                fatalError(error.localizedDescription)
            }
            return URI
        }
        return nil
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
