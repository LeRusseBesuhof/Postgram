import UIKit
import SnapKit

final class PublicationViewCell: UICollectionViewCell {
    // MARK: private properties
    static let reuseID = PublicationViewCell.description()
    
    private lazy var titleLabel : UILabel = {
        $0.text = "Simple text"
        $0.font = .getJimNightshadeFont(fontSize: 32)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private methods
    private func setupLayoutConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    // MARK: internal methods
    func setupCell(by item: InputData, _ image: UIImage) {
        addSubviews(titleLabel)
    }
}
