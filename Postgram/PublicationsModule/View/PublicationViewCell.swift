import UIKit
import SnapKit

final class PublicationViewCell: UICollectionViewCell {
    // MARK: private properties
    static let reuseID = "reuseID"
    
    private lazy var titleLabel : UILabel = {
        $0.font = .getCinzelFont(fontType: .bold, fontSize: 40)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
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
        $0.backgroundColor = .darkGray
        $0.textAlignment = .left
        $0.font = .getCinzelFont()
        return $0
    }(UILabel())
    
    // MARK: init
    private let itemSize = UIScreen.main.bounds.width - 70
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textBackgroundView.addSubview(textLabel)
        addSubviews(titleLabel, dataLabel, postImageView, textBackgroundView)
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private methods
    private func setupLayoutConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(itemSize)
            $0.leading.equalToSuperview()
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
            // $0.verticalEdges.equalToSuperview().inset(50)
            $0.centerY.equalToSuperview()
        }
        
        textBackgroundView.snp.makeConstraints {
            $0.top.equalTo(postImageView.snp.bottom).offset(20)
            $0.width.equalTo(itemSize)
            $0.leading.equalToSuperview()
            // $0.height.equalTo(textLabel.snp.height).inset(20)
            $0.bottom.equalTo(textLabel.snp.bottom).inset(20)
        }
        
        snp.makeConstraints {
            $0.bottom.equalTo(textBackgroundView.snp.bottom)
        }
    }
    
    // MARK: internal methods
    func setupCell(by item: InputData, _ image: UIImage) {
        titleLabel.text = item.header
        dataLabel.text = item.date
        postImageView.image = image
        textLabel.text = item.text
    }
}
