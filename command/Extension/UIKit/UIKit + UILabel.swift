import UIKit

extension UILabel {
    convenience init(text : String?, font : UIFont? = .systemFont(ofSize: 14)) {
        self.init()
        self.font = font
        self.text = text
        textAlignment = .center
    }
}
