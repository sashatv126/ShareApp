import RxDataSources

typealias CellSections = SectionModel<Int, CellSectionsProtocol>

protocol CellSectionsProtocol {
    
    var title : String { get }
}

struct CellViewModel : CellSectionsProtocol {
    
    var title : String
}

extension CellViewModel {
    
    init(model : String) {
        self.title = model
    }
}
