import UIKit
import RxSwift
import RxCocoa

class MainViewController : UIViewController {
    
    var menuView = MenuViewController()
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

