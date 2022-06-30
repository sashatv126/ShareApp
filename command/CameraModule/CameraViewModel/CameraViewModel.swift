import RxSwift
import RxCocoa

class CameraViewModel : CameraViewModelProtocol {
    
    var input: CameraInput
    
    private let bag = DisposeBag()
    
    private let newPhotoSubject = PublishSubject<Void>()
    private let saveSubject = PublishSubject<Void>()
    private let photoSubject = PublishSubject<Void>()
    
    private let service : CameraManager?
    
    init(input : CameraInput, router : Routable, service : CameraManager) {
        self.input = input
        self.service = service
    }
    
    func transform(_ input: CameraInput) -> CameraOutput {
        return CameraOutput(save: save,
                            photo: photo,
                            newPhoto: newPhoto)
    }
}

private extension CameraViewModel {
    var save : Driver<Void> {
        saveSubject.asDriver(onErrorJustReturn: ())
    }
    
    var photo : Driver<Void> {
        photoSubject.asDriver(onErrorJustReturn: ())
    }
    
    var newPhoto : Driver<Void> {
        newPhotoSubject.asDriver(onErrorJustReturn: ())
    }
    
    func validPass(_ input : CameraInput) {
        let result = input.save
            .share()
        result.map({
        })
        .subscribe(saveSubject)
        .disposed(by: bag)
    }
    
}
