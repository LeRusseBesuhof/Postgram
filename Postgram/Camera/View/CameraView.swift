import UIKit
import SnapKit

protocol CameraViewProtocol : UIStackView {
    var captureImage : (()-> Void)? { get set }
    var makePhoto : (()-> Void)? { get set }
    var switchCamera : (()-> Void)? { get set }
    
    var imagePicker : UIImagePickerController { get }
    
    var leftButtonConstant : CGFloat { get }
    func setLastGalleryImage(_ image: UIImage)
}

final class CameraView: UIStackView {
    // MARK: private size constants
    enum ConstantSnap : CGFloat {
        case leftButtonRadius = 15.0
        case centerButtonRadius = 25.0
        case rightButtonRadius = 20.0
    }
    
    // MARK: delegate properties
    internal var captureImage : (()-> Void)?
    internal var makePhoto : (()-> Void)?
    internal var switchCamera : (()-> Void)?
    internal var leftButtonConstant : CGFloat {
        get {
            ConstantSnap.leftButtonRadius.rawValue * 2
        }
    }
    
    internal lazy var imagePicker : UIImagePickerController = {
        $0.delegate = self
        $0.allowsEditing = true
        $0.sourceType = .photoLibrary
        return $0
    }(UIImagePickerController())
    
    // MARK: private properties
    private lazy var captureImageButton : UIButton = {
        $0.layer.cornerRadius = ConstantSnap.leftButtonRadius.rawValue
        $0.backgroundColor = .appDarkGreen
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(onCaptureImageButtonTouch), for: .touchDown)
        return $0
    }(UIButton())
    
    @objc private func onCaptureImageButtonTouch() {
        captureImage?()
    }
    
    private lazy var makePhotoButton : UIButton = {
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.appDarkGreen.cgColor
        $0.layer.cornerRadius = ConstantSnap.centerButtonRadius.rawValue
        $0.setBackgroundImage(UIImage(systemName: "circle.fill"), for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(onMakePhotoButtonTouch), for: .touchDown)
        return $0
    }(UIButton())
    
    @objc private func onMakePhotoButtonTouch() {
        makePhoto?()
    }
    
    private lazy var changeCameraModeButton : UIButton = {
        $0.layer.cornerRadius = ConstantSnap.rightButtonRadius.rawValue
        $0.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .appDarkGreen
        $0.addTarget(self, action: #selector(onSwitchCameraButtonTouch), for: .touchDown)
        return $0
    }(UIButton())
    
    @objc private func onSwitchCameraButtonTouch() {
        switchCamera?()
    }
    
    private lazy var buttonsStack : UIStackView = { stack in
        [captureImageButton, makePhotoButton, changeCameraModeButton].forEach { stack.addArrangedSubview($0) }
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.backgroundColor = .appLightGray
        return stack
    }(UIStackView())
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        activateConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: private funcs
private extension CameraView {
    private func setUpView() {
        backgroundColor = .appLightGray
        addSubview(buttonsStack)
    }
    
    private func activateConstraints() {        
        captureImageButton.snp.makeConstraints {
            $0.width.height.equalTo(ConstantSnap.leftButtonRadius.rawValue * 3)
        }
        
        makePhotoButton.snp.makeConstraints {
            $0.width.height.equalTo(ConstantSnap.centerButtonRadius.rawValue * 2)
        }
        
        changeCameraModeButton.snp.makeConstraints {
            $0.width.height.equalTo(ConstantSnap.rightButtonRadius.rawValue * 2)
        }
        
        buttonsStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(65)
        }
    }
}

extension CameraView : CameraViewProtocol {
    func setLastGalleryImage(_ image: UIImage) {
        captureImageButton.setImage(image, for: .normal)
    }
}

extension CameraView : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            print("Image've been chosen")
        }
        picker.dismiss(animated: true)
    }
}
