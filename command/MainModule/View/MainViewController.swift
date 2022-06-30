import UIKit
import RxSwift
import RxCocoa

class MainViewController : UIViewController {
    
    lazy var searchBar : UISearchBar = {
        let search = UISearchBar()
        search.backgroundImage = UIImage()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    var menuView = MenuViewController()
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.navigationController?.isNavigationBarHidden = false
    }
    
}

