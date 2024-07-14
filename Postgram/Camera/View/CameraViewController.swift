import UIKit
import SnapKit
import AVFoundation

protocol CameraViewControllerProtocol : AnyObject {
    func setupPreviewLayer(_ previewLayer : AVCaptureVideoPreviewLayer)
    func presentImagePicker(_ controller: UIImagePickerController)
}

final class CameraViewController: UIViewController {
    // MARK: private properties
    private let cView : CameraViewProtocol!
    private let presenter : CameraPresenterProtocol!
    
    // MARK: init
    struct Dependencies {
        let presenter : CameraPresenterProtocol!
    }
    
    init(_ dependencies: Dependencies) {
        self.cView = CameraView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: load views
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cView)
        view.backgroundColor = .black
        setUpView()
    }
    
    override func loadView() {
        super.loadView()
        presenter.loadPresenter(view: cView, controller: self)
    }
}

// MARK: private methods
private extension CameraViewController {
    private func setUpView() {
        cView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}

extension CameraViewController : CameraViewControllerProtocol {
    func setupPreviewLayer(_ previewLayer : AVCaptureVideoPreviewLayer) {
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.frame
        
        view.layer.addSublayer(previewLayer)
    }
    
    func presentImagePicker(_ controller: UIImagePickerController) {
        self.present(controller, animated: true)
    }
}
