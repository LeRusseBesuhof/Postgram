import UIKit
import SnapKit

protocol CellButtonDelegate : AnyObject {
    func changeButtonTapped(_ id: String)
    func deleteButtonTapped(_ id: String)
}

final class PublicationViewCell: UICollectionViewCell {
    // MARK: internal properties & methods
    var postID = String()
    weak var changeButtonDelegate : CellButtonDelegate?
    weak var deleteButtonDelegate : CellButtonDelegate?
    
    override func prepareForReuse() {
        postImageView.image = nil
    }
    
    // MARK: private properties
    static let reuseID = "reuseID"
    private let itemSize = UIScreen.main.bounds.width - 70
    private let buttonRadius : CGFloat = 15
    
    private lazy var titleLabel : UILabel = {
        $0.font = .getCinzelFont(fontType: .bold, fontSize: 40)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var changePostButton : UIButton = {
        $0.layer.cornerRadius = buttonRadius
        $0.setBackgroundImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        $0.addTarget(self, action: #selector(onChangePostTouch), for: .touchDown)
        return $0
    }(UIButton())
    
    @objc private func onChangePostTouch() {
        changeButtonTapped(postID)
    }
    
    private lazy var deletePostButton : UIButton = {
        $0.layer.cornerRadius = buttonRadius
        $0.setBackgroundImage(UIImage(systemName: "trash.circle"), for: .normal)
        $0.tintColor = .red
        $0.addTarget(self, action: #selector(onDeletePostTouch), for: .touchDown)
        return $0
    }(UIButton())
    
    @objc private func onDeletePostTouch() {
        deleteButtonTapped(postID)
    }
    
    private lazy var dataLabel : UILabel = {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var postImageView : UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .appLightGray
        return $0
    }(UIImageView())
    
    private lazy var textBackgroundView : UIView = {
        $0.backgroundColor = .appLightGray
        $0.layer.cornerRadius = 15
        return $0
    }(UIView())
    
    private lazy var textLabel : UILabel = {
        $0.font = .getCinzelFont(fontSize: 14)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        textBackgroundView.addSubview(textLabel)
        addSubviews(titleLabel, changePostButton, deletePostButton, dataLabel, postImageView, textBackgroundView)
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private methods
    private func setupLayoutConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(itemSize - 75)
            $0.leading.equalToSuperview()
        }
        
        changePostButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(10)
            $0.width.height.equalTo(buttonRadius * 2)
        }
        
        deletePostButton.snp.makeConstraints {
            $0.centerY.equalTo(changePostButton)
            $0.leading.equalTo(changePostButton.snp.trailing).offset(7)
            $0.width.height.equalTo(buttonRadius * 2)
        }
        
        dataLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(itemSize)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
        
        postImageView.snp.makeConstraints {
            $0.top.equalTo(dataLabel.snp.bottom).offset(15)
            $0.height.equalTo(itemSize)
            $0.width.equalTo(itemSize)
            $0.leading.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        
        textBackgroundView.snp.makeConstraints {
            $0.top.equalTo(postImageView.snp.bottom).offset(20)
            $0.width.equalTo(itemSize)
            $0.leading.equalToSuperview()
            $0.bottom.equalTo(textLabel.snp.bottom).offset(20)
        }
        
        snp.makeConstraints {
            $0.bottom.equalTo(textBackgroundView.snp.bottom)
        }
    }
    
    // MARK: internal methods
    func setupCell(by item: InputData, _ image: UIImage) {
        isUserInteractionEnabled = true
        postID = item.id
        titleLabel.text = item.header
        dataLabel.text = item.date
        postImageView.image = image
        textLabel.text = item.text
    }
}

extension PublicationViewCell : CellButtonDelegate {
    func changeButtonTapped(_ id: String) {
        changeButtonDelegate?.changeButtonTapped(id)
    }
    
    func deleteButtonTapped(_ id: String) {
        deleteButtonDelegate?.deleteButtonTapped(id)
    }
}
