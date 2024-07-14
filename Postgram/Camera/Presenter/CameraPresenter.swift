import Foundation
import UIKit
import AVFoundation
import Photos

protocol CameraPresenterProtocol : AnyObject {
    func loadPresenter(view: CameraViewProtocol, controller: CameraViewControllerProtocol)
}

protocol CameraPresenterDelegate : AnyObject {
    func takeImageData(_ imageData: Data)
}

final class CameraPresenter {
    // MARK: private properties
    private let router : Router!
    private let cameraService : CameraServiceDelegate!
    private weak var view : CameraViewProtocol?
    private weak var controller : CameraViewControllerProtocol?
    
    // MARK: init
    struct Dependencies {
        let router : Router
        let cameraService : CameraServiceDelegate
    }
    
    init(_ dependencies: Dependencies) {
        self.router = dependencies.router
        self.cameraService = dependencies.cameraService
        
        cameraService.setCameraPresenterDelegate(self)
    }
}

// MARK: private methods
private extension CameraPresenter {
    private func setupHandlers() {
        view?.makePhoto = { [weak self] in
            guard let self = self else { return }
            
            onMakePhotoTouched()
        }
        
        view?.switchCamera = { [weak self] in
            guard let self = self else { return }
            
            onSwitchCameraTouched()
        }
        
        view?.captureImage = { [weak self] in
            guard let self = self else { return }
            
            onCaptureImageTouched()
        }
    }
    
    private func configureViews() {
        setupControllerPreviewLayer()
        fetchLastImageFromGallery()
    }
    
    private func setupControllerPreviewLayer() {
        let previewLayer = cameraService.getPreviewLayer()
        controller?.setupPreviewLayer(previewLayer)
    }
    
    private func onMakePhotoTouched() {
        cameraService.takePhoto()
    }
    
    private func onSwitchCameraTouched() {
        cameraService.switchCamera()
    }
    
    private func onCaptureImageTouched() {
        if let view = view {
            controller?.presentImagePicker(view.imagePicker)
        }
    }
    
    private func fetchLastImageFromGallery() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.fetchLimit = 1
        
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        if let lastAsset = fetchResult.firstObject {
            let imageManager = PHImageManager.default()
            let size = view?.leftButtonConstant ?? 0
            let targetSize = CGSize(width: size, height: size)
            
            imageManager.requestImage(for: lastAsset, targetSize: targetSize, contentMode: .aspectFill, options: nil) { [weak self] (image, info) in
                guard let self = self else { return }
                
                guard let image = image else {
                    print("no last image")
                    return
                }
                view?.setLastGalleryImage(image)
            }
        }
    }
}

extension CameraPresenter : CameraPresenterProtocol {
    func loadPresenter(view: CameraViewProtocol, controller: CameraViewControllerProtocol) {
        self.view = view
        self.controller = controller
        
        self.view?.setCameraPresenterDelegate(self)
        self.configureViews()
        self.setupHandlers()
    }
}

extension CameraPresenter : CameraPresenterDelegate {
    func takeImageData(_ imageData: Data) {
        let targetController = CreationAssembly.build(with: imageData)
        router.setUpTargetController(with: targetController)
        router.pushTargetController()
    }
}
