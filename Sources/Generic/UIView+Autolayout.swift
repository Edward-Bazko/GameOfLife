import UIKit

extension UIView {
    func fillSuperview() {
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: superview!.topAnchor),
                                     bottomAnchor.constraint(equalTo: superview!.bottomAnchor),
                                     leadingAnchor.constraint(equalTo: superview!.leadingAnchor),
                                     trailingAnchor.constraint(equalTo: superview!.trailingAnchor)])
    }
}
