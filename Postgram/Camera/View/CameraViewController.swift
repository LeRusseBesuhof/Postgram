import UIKit
import SnapKit

protocol CameraViewControllerProtocol : AnyObject {
    
}

final class CameraViewController: UIViewController {
    // MARK: private properties
    private let cView : CameraViewProtocol!
    
    // MARK: init
    init() {
        self.cView = CameraView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: load views
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cView)
        view.backgroundColor = .black
        setUpView()
    }
}

// MARK: private methods
private extension CameraViewController {
    private func setUpView() {
        cView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(120)
        }
    }
}

extension CameraViewController : CameraViewControllerProtocol {
    
}
