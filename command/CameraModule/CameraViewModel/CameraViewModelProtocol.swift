import RxSwift
import RxCocoa

struct CameraInput {
    let save : Observable<Void>
    let photo : Observable<Void>
    let newPhoto : Observable<Void>
}

struct CameraOutput {
    let save : Driver<Void>
    let photo : Driver<Void>
    let newPhoto : Driver<Void>
}

protocol CameraViewModelProtocol {
    
    typealias ViewModelBuilder = (CameraInput) -> CameraViewModelProtocol
    
    var input : CameraInput { get set }
    
    func transform(_ input : CameraInput) -> CameraOutput
}
