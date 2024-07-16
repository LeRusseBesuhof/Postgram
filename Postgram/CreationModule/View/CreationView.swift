import UIKit
import SnapKit

protocol CreationViewProtocol : UIImageView {
    func setCapturedImage(_ image: UIImage)
}

final class CreationView: UIImageView {
    // MARK: private properties
    private let canvasView : UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        return $0
    }(UIView())
    
    private lazy var headerTextField : UITextField = {
        $0.backgroundColor = .appLightGray
        $0.layer.cornerRadius = 15
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.appPlaceholder,
        ]
        $0.attributedPlaceholder = NSAttributedString(string: "Заголовок", attributes: attributes)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: $0.frame.height))
        $0.leftView = leftView
        $0.leftViewMode = .always
        return $0
    }(UITextField())
    
    private lazy var tagPickerView : UIPickerView = {
        $0.dataSource = self
        return $0
    }(UIPickerView())
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: private methods
private extension CreationView {
    private func setUpView() {
        image = .background
        isUserInteractionEnabled = true
        canvasView.addSubviews(headerTextField)
        addSubviews(canvasView)
        
        activateConstraints()
    }
    
    private func activateConstraints() {
        canvasView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview().inset(50)
        }
        
        headerTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
}

// MARK: internal methods
extension CreationView : CreationViewProtocol {
    func setCapturedImage(_ image: UIImage) {
        
    }
}

extension CreationView : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        0
    }
}
