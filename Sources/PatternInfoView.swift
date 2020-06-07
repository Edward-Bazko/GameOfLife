import UIKit

class PatternInfoView: UIView {
    
    private let nameLabel = UILabel().autolayout()
    private let authorLabel = UILabel().autolayout()
    private let commentLabel = UILabel().autolayout()
    
    init() {
        super.init(frame: .zero)
        let sv = UIStackView().autolayout()
        sv.spacing = 2
        sv.axis = .vertical
        sv.distribution = .fill
        
        addSubview(sv)
        sv.fillSuperview()
        
        nameLabel.font = .preferredFont(forTextStyle: .body)
        authorLabel.font = .preferredFont(forTextStyle: .caption1)
        commentLabel.font = .preferredFont(forTextStyle: .footnote)
        
        nameLabel.numberOfLines = 0
        authorLabel.numberOfLines = 0
        commentLabel.numberOfLines = 0
        
        nameLabel.textColor = .label
        authorLabel.textColor = .label
        commentLabel.textColor = UIColor.label.withAlphaComponent(0.7)
                
        sv.addArrangedSubview(nameLabel)
        sv.addArrangedSubview(authorLabel)
        sv.addArrangedSubview(commentLabel)
        
        backgroundColor = UIColor.white.withAlphaComponent(0.7)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func renderPattern(_ pattern: Pattern) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { _ in
            self.nameLabel.text = pattern.name
            self.authorLabel.text = pattern.author
            self.commentLabel.text = pattern.comment?.joined(separator: "\n")
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 1
            }, completion: nil)
        }
    }
}

extension UIView {
    func autolayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
