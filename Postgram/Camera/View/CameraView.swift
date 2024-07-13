import UIKit
import SnapKit

protocol CameraViewProtocol : UIStackView {
    
}

final class CameraView: UIStackView {
    // MARK: private size constants
    enum ConstantSnap : CGFloat {
        case leftButtonRadius = 15.0
        case centerButtonRadius = 25.0
        case rightButtonRadius = 20.0
    }
    
    // MARK: private properties
    private lazy var captureImageButton : UIButton = {
        $0.layer.cornerRadius = ConstantSnap.leftButtonRadius.rawValue
        $0.backgroundColor = .appDarkGreen
        $0.addTarget(self, action: #selector(onCaptureImageButtonTouch), for: .touchDown)
        return $0
    }(UIButton())
    
    @objc private func onCaptureImageButtonTouch() {
        print(1)
    }
    
    private lazy var makePhoto : UIButton = {
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.appDarkGreen.cgColor
        $0.layer.cornerRadius = ConstantSnap.centerButtonRadius.rawValue
        $0.setBackgroundImage(UIImage(systemName: "circle.fill"), for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(onMakePhotoButtonTouch), for: .touchDown)
        return $0
    }(UIButton())
    
    @objc private func onMakePhotoButtonTouch() {
        print(2)
    }
    
    private lazy var changeCameraMode : UIButton = {
        $0.layer.cornerRadius = ConstantSnap.rightButtonRadius.rawValue
        $0.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .appDarkGreen
        $0.addTarget(self, action: #selector(onChangeCameraModeButtonTouch), for: .touchDown)
        return $0
    }(UIButton())
    
    @objc private func onChangeCameraModeButtonTouch() {
        print(3)
    }
    
    private lazy var buttonsStack : UIStackView = { stack in
        [captureImageButton, makePhoto, changeCameraMode].forEach { stack.addArrangedSubview($0) }
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
        
        makePhoto.snp.makeConstraints {
            $0.width.height.equalTo(ConstantSnap.centerButtonRadius.rawValue * 2)
        }
        
        changeCameraMode.snp.makeConstraints {
            $0.width.height.equalTo(ConstantSnap.rightButtonRadius.rawValue * 2)
        }
        
        buttonsStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(70)
        }
    }
}

extension CameraView : CameraViewProtocol {
    
}
