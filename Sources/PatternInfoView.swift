import UIKit

class PatternInfoView: UIView {
    
    private let nameLabel = UITextView().autolayout()
    private let authorLabel = UITextView().autolayout()
    private let commentTextView = UITextView().autolayout()
    
    init() {
        super.init(frame: .zero)
        let sv = UIStackView().autolayout()
        sv.spacing = 2
        sv.axis = .vertical
        sv.distribution = .fill
        sv.isLayoutMarginsRelativeArrangement = true
        
        addSubview(sv)
        sv.fillSuperview()
        
        nameLabel.font = .preferredFont(forTextStyle: .body)
        authorLabel.font = .preferredFont(forTextStyle: .caption1)
        commentTextView.font = .preferredFont(forTextStyle: .footnote)
                        
        nameLabel.textColor = .label
        authorLabel.textColor = .label
        commentTextView.textColor = UIColor.label.withAlphaComponent(0.7)

        [nameLabel, authorLabel, commentTextView].forEach { tv in
            tv.isScrollEnabled = false
            tv.isEditable = false
            tv.isSelectable = true
            tv.dataDetectorTypes = [.link]
            tv.backgroundColor = .clear
            tv.textContainerInset = .init(top: 0, left: 8, bottom: 0, right: 8)
            tv.textContainer.lineFragmentPadding = 0
        }
        
        nameLabel.textContainerInset.top = 8
        
        sv.addArrangedSubview(nameLabel)
        sv.addArrangedSubview(authorLabel)
        sv.addArrangedSubview(commentTextView)
        
        backgroundColor = UIColor.white.withAlphaComponent(0.7)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func renderPattern(_ pattern: Pattern) {
        UIView.animate(withDuration: 0.15, animations: {
            self.alpha = 0
        }) { _ in
            self.nameLabel.text = pattern.name
            self.authorLabel.text = pattern.author
            self.commentTextView.text = pattern.comment?.joined(separator: "\n")
            
            self.authorLabel.isScrollEnabled = pattern.author == nil // HACK: text view shoud be zero-height when author is nil
            
            UIView.animate(withDuration: 0.15, animations: {
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
