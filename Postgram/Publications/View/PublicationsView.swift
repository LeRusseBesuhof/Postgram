import UIKit

protocol PublicationsViewProtocol : UIImageView{
    
}

final class PublicationsView : UIImageView {
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
private extension PublicationsView {
    private func setUpView() {
        backgroundColor = .systemMint
    }
}

extension PublicationsView : PublicationsViewProtocol {
    
}
