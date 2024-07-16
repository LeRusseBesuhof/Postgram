import Foundation
import UIKit

protocol PublicationsViewControllerProtocol : AnyObject {
    
}

final class PublicationsViewController: UIViewController {
    // MARK: private properties
    private let pView : PublicationsViewProtocol
    private let presenter : PublicationsPresenterProtocol
    
    // MARK: init
    struct Dependencies {
        let presenter : PublicationsPresenterProtocol
    }
    
    init(_ dependencies: Dependencies) {
        self.pView = PublicationsView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: load elements
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pView)
        // print(FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first)
    }
    
    override func loadView() {
        super.loadView()
        presenter.loadPresenter(view: pView, controller: self)
    }
}

extension PublicationsViewController : PublicationsViewControllerProtocol {
    
}
