import RxCocoa
import RxSwift

struct MenuInput {
    let buttonSignOut : Observable<Void>
}

struct MenuOutput {
    let signOut : Driver<Void>
    let cell : Driver<[CellSections]>
}

protocol MenuViewModelProtocol {
    
    var input : MenuInput { get set }
    
    func transform() -> MenuOutput
}


