import UIKit
import SnapKit

protocol PublicationsViewProtocol : UIImageView{
    var createPost : (() -> Void)? { get set }
}

final class PublicationsView : UIImageView {
    // MARK: internal properties
    var createPost: (() -> Void)?
    
    // MARK: private properties
    private let canvasView : UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        return $0
    }(UIView())
    
    private lazy var createButton : UIButton = {
        $0.addTarget(self, action: #selector(onCreatePostButtonTouch), for: .touchDown)
        $0.backgroundColor = .appLightGray
        $0.setTitle("Create post", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        return $0
    }(UIButton())
    
    @objc private func onCreatePostButtonTouch() {
        createPost?()
    }
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: private methods
private extension PublicationsView {
    private func setupView() {
        image = .background
        isUserInteractionEnabled = true
        
        canvasView.addSubviews(createButton)
        addSubviews(canvasView)
        
        activateConstraints()
    }
    
    private func activateConstraints() {
        canvasView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.bottom.equalToSuperview().inset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        createButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
}

extension PublicationsView : PublicationsViewProtocol {
    
}
