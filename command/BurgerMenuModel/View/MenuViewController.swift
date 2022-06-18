import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MenuViewController : UIViewController {
    
    private lazy var buttonMenu : UIButton = {
        let button = UIButton(title: "Sign out",
                              titleColor: .black,
                              backGroundColor: .gray,
                              fornt: UIFont.systemFont(ofSize: 25),
                              isShadow: true,
                              cornerRadus: 10)
        return button
    }()
    
    private lazy var tableView : UITableView = UITableView()
    private var viewModel : MenuViewModelProtocol!
    private static let cellId = "MenuCell"
    private let bag = DisposeBag()
    
    private lazy var datasource = RxTableViewSectionedReloadDataSource<CellSections>(configureCell: { _,tableView,indexPth,item  in
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuViewController.cellId, for: indexPth)
        cell.backgroundColor = .gray
        cell.textLabel?.text = item.title
        cell.selectedBackgroundView?.layer.cornerRadius = 20
        cell.layer.cornerRadius = 20
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 4
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize(width: 0, height: 4)
        cell.imageView?.image = UIImage(systemName: "plus")
        return cell 
    } )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelAssembly()
        bind()
        setupConstraints()
    }
}

private extension MenuViewController {
    
    func viewModelAssembly() {

        viewModel = MenuViewModel(input: MenuInput(buttonSignOut: buttonMenu
            .rx
            .tap
            .asObservable()),
                                  service: FirebaseManager())
    }
    
    func bind() {
        let output = viewModel.transform()
        
        output
            .signOut
            .drive(onNext: { _ in
            })
            .disposed(by: bag)
        
        output
            .cell
            .drive(tableView.rx.items(dataSource: datasource))
            .disposed(by: bag)
    }
}

private extension MenuViewController {
    
    func setupConstraints() {
        self.tableView.register(UITableViewCell.self,
                                forCellReuseIdentifier: MenuViewController.cellId)
        tableView.backgroundColor = .gray
        tableView.isScrollEnabled = false
        tableView.rowHeight = 60
        tableView.separatorColor = .gray
        view.addSubview(tableView)
        tableView.addSubview(buttonMenu)
        buttonMenu.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buttonMenu.leadingAnchor.constraint(equalTo: tableView.leadingAnchor,constant: 15),
            buttonMenu.centerYAnchor.constraint(equalTo: tableView.centerYAnchor,constant: 200),
            buttonMenu.widthAnchor.constraint(equalToConstant: 200),
            buttonMenu.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
