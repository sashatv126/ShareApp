import UIKit
import RxCocoa

extension MainViewController {
    func setupView() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
    }
    
    func setupSearch() {
       
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            searchBar.heightAnchor.constraint(equalToConstant: 60),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90)
        ])
    }
}
