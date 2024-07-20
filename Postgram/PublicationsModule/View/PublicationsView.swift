import UIKit
import SnapKit

protocol PublicationsViewProtocol : UIImageView{
    var createPost : (() -> Void)? { get set }
    var publicationsMockData : [InputData] { get set }
    var images : [UIImage] { get set }
    
    func reloadCollectionComponents()
}

final class PublicationsView : UIImageView {
    // MARK: internal properties
    var createPost: (() -> Void)?
    var publicationsMockData : [InputData] = []
    var images : [UIImage] = []
    
    // MARK: private properties
    private let canvasView : UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        return $0
    }(UIView())
    
    private let layout : UICollectionViewFlowLayout = {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        return $0
    }(UICollectionViewFlowLayout())
    
    private lazy var collectionView : UICollectionView = {
        $0.dataSource = self
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layout))
    
    private lazy var createButton : UIButton = {
        $0.addTarget(self, action: #selector(onCreatePostButtonTouch), for: .touchDown)
        $0.backgroundColor = .appLightGray
        $0.setTitle("Create post", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .getCinzelFont(fontSize: 24)
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
            $0.top.equalToSuperview().inset(50)
            $0.bottom.equalToSuperview().inset(30)
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
    func reloadCollectionComponents() {
        collectionView.reloadData()
    }
}

extension PublicationsView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        publicationsMockData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = publicationsMockData[indexPath.item]
        let currentImage = images[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PublicationViewCell.reuseID, for: indexPath) as? PublicationViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(by: item, currentImage)
        return cell
    }
    
    
}
