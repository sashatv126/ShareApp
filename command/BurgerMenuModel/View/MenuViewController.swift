import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MenuViewController : UIViewController {
    
    private lazy var buttonMenu : UIButton = {
        let button = UIButton(title: "Sign out",
                              titleColor: .white,
                              backGroundColor: .systemBlue,
                              fornt: UIFont.systemFont(ofSize: 18),
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
        cell.backgroundColor = UIColor(red: 14/255.0,
                                       green: 15/255.0,
                                       blue: 13/255.0,
                                       alpha: 1.0)
        cell.textLabel?.text = item.title
        cell.textLabel?.textColor = .white
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
        tableView.backgroundColor = UIColor(red: 14/255.0,
                                            green: 15/255.0,
                                            blue: 13/255.0,
                                            alpha: 1.0)
        tableView.isScrollEnabled = false
        tableView.rowHeight = 60
        tableView.separatorColor = UIColor(red: 14/255.0,
                                           green: 15/255.0,
                                           blue: 13/255.0,
                                           alpha: 1.0)
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
            buttonMenu.centerYAnchor.constraint(equalTo: tableView.centerYAnchor,constant: 270),
            buttonMenu.widthAnchor.constraint(equalToConstant: 200),
            buttonMenu.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
