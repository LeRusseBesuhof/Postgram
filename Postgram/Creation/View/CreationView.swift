import UIKit
import SnapKit

protocol CreationViewProtocol : UIImageView {
    
}

final class CreationView: UIImageView {
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
    }
}

// MARK: internal methods
extension CreationView : CreationViewProtocol {
    
}
