import UIKit
import SnapKit

protocol CreationViewProtocol : UIImageView {
    func setCapturedImage(_ image: UIImage)
    func getInputData() -> InputData?
    func getImage() -> UIImage
    
    var createPost : (() -> Void)? { get set }
}

final class CreationView: UIImageView {
    // MARK: internal var
    var createPost : (() -> Void)?
    
    // MARK: private properties
    private let canvasView : UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        return $0
    }(UIView())
    
    private let titleLabel : UILabel = {
        $0.text = .titlePost
        $0.font = .getCinzelFont(fontType: .black, fontSize: 28)
        $0.textAlignment = .left
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private lazy var headerTextField : UITextField = {
        $0.backgroundColor = .appLightGray
        $0.layer.cornerRadius = 20
        $0.delegate = self
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.appPlaceholder,
            NSAttributedString.Key.font: UIFont.getCinzelFont()
        ]
        $0.attributedPlaceholder = NSAttributedString(string: .header, attributes: attributes)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
        $0.leftView = leftView
        $0.leftViewMode = .always
        return $0
    }(UITextField())
    
    private lazy var postImageView : UIImageView = {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .appLightGray
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private lazy var postTextView : UITextView = {
        $0.layer.cornerRadius = 20
        $0.font = .getCinzelFont()
        $0.backgroundColor = .appLightGray
        $0.isEditable = true
        $0.delegate = self
        $0.textAlignment = .left
        $0.textColor = .black
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        return $0
    }(UITextView())
    
    private lazy var createPostButton : UIButton = {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.appDarkGreen.cgColor
        $0.layer.borderWidth = 1.5
        $0.layer.cornerRadius = 20
        $0.setTitle(.makePost, for: .normal)
        $0.setTitleColor(.appDarkGreen, for: .normal)
        $0.titleLabel?.font = .getCinzelFont(fontType: .regular, fontSize: 24)
        $0.addTarget(self, action: #selector(onCreatePostTouch), for: .touchDown)
        return $0
    }(UIButton())
    
    @objc private func onCreatePostTouch() {
        createPost?()
    }
    
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
        postTextView.setUpTextView(.smthInteresting, .appPlaceholder)
        canvasView.addSubviews(titleLabel, headerTextField, postImageView, postTextView, createPostButton)
        addSubviews(canvasView)
        
        activateConstraints()
    }
    
    private func activateConstraints() {
        canvasView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(40)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }
        
        headerTextField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.height.equalTo(50)
        }
        
        postImageView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(headerTextField)
            $0.top.equalTo(headerTextField.snp.bottom).offset(15)
            $0.height.equalTo(250)
        }
        
        postTextView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(postImageView)
            $0.top.equalTo(postImageView.snp.bottom).offset(15)
            $0.height.equalTo(130)
        }
        
        createPostButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(postTextView)
            $0.top.equalTo(postTextView.snp.bottom).offset(15)
            $0.bottom.equalToSuperview().inset(15)
        }
    }
}

// MARK: internal methods
extension CreationView : CreationViewProtocol {
    func setCapturedImage(_ image: UIImage) {
        postImageView.image = image
        postImageView.reloadInputViews()
    }
    
    func getImage() -> UIImage {
        return postImageView.image!
    }
    
    func getInputData() -> InputData? {
        let inputData = InputData(
            header: headerTextField.text ?? "",
            date: Date.now.formatDate(),
            text: postTextView.text,
            imageName: UUID().uuidString + ".jpeg"
        )
        return inputData
    }
}

extension CreationView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreationView : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == .smthInteresting {
            textView.setUpTextView("", .black)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.setUpTextView(.smthInteresting, .appPlaceholder)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(text)
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
