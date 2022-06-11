import UIKit

extension UIButton {
    convenience init(title : String?,
                         titleColor : UIColor,
                         backGroundColor : UIColor,
                         fornt : UIFont? = .systemFont(ofSize: 20),
                         isShadow : Bool = false,
                         cornerRadus : CGFloat = 30) {
            self.init(type : .system)
            self.setTitle(title, for: .normal)
            self.setTitleColor(titleColor, for: .normal)
            self.backgroundColor = backGroundColor
            self.titleLabel?.font = fornt
            self.layer.cornerRadius = cornerRadus
            if isShadow {
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowRadius = 4
                self.layer.shadowOpacity = 0.5
                self.layer.shadowOffset = CGSize(width: 0, height: 4)
            }
        }
        
        func addImageButton() {
            let logo = UIImageView(image: UIImage(named: "goo"), contentMode: .scaleAspectFit)
            logo.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(logo)
            
            NSLayoutConstraint.activate([
                logo.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 24),
                logo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                logo.heightAnchor.constraint(equalToConstant: 25),
                logo.widthAnchor.constraint(equalToConstant: 25)
            ])
           
        }
}
