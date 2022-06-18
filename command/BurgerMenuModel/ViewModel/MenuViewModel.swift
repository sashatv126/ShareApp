import RxSwift
import RxCocoa

final class MenuViewModel : MenuViewModelProtocol {

    private var bag = DisposeBag()
    private var signOutSubject = PublishSubject<Void>()
    private var service : FirebaseService
    
    var input : MenuInput
    
    init(input : MenuInput, service : FirebaseService) {
        self.input = input
        self.service = service
    }
    
    func transform() -> MenuOutput {
        signOut(input)
        return MenuOutput(signOut: signOut,
                          cell: getCells())
    }
}

private extension MenuViewModel {
    
    var signOut : Driver<Void> {
        signOutSubject.asDriver(onErrorJustReturn: ())
    }
    
    func signOut(_ input : MenuInput) {
        let result = input.buttonSignOut
            .share()
        result.map{[weak self] _ in
            self?.service.logOut()
        }
            .subscribe(signOutSubject)
            .disposed(by: bag)
    }
    
    
    func getCells() -> Driver<[CellSections]> {
        let array = [CellViewModel(model: "Profile"),CellViewModel(model: "Settings")]
        let cells = Observable
            .from(optional: array)
            .map({
               [CellSections(model: 0, items: $0)]
            })
            .asDriver(onErrorJustReturn: [])
        
        return cells
    }
}

