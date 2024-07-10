import UIKit

protocol CreationViewControllerProtocol : AnyObject {
    
}

final class CreationViewController: UIViewController {
    
    // MARK: private properties
    private let cView : CreationViewProtocol
    private let presenter : CreationPresenterProtocol!
    
    // MARK: init
    struct Dependencies {
        let presenter : CreationPresenterProtocol
    }
    
    init(_ dependencies: Dependencies) {
        self.presenter = dependencies.presenter
        self.cView = CreationView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: load elements
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cView)
    }
    
    override func loadView() {
        super.loadView()
        presenter.loadPresenter(with: cView, controller: self)
    }
}

extension CreationViewController : CreationViewControllerProtocol {
    
}
