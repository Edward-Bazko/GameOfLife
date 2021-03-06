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
        sv.directionalLayoutMargins = .init(top: 8, leading: 0, bottom: 8, trailing: 0)
        
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
        
        sv.addArrangedSubview(nameLabel)
        sv.addArrangedSubview(authorLabel)
        sv.addArrangedSubview(commentTextView)
        
        backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.7)
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func renderPattern(_ pattern: Pattern) {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.8
        }) { _ in
            self.nameLabel.text = pattern.name
            self.authorLabel.text = pattern.author
            self.commentTextView.text = pattern.comment?.joined(separator: "\n")
            
            self.authorLabel.isScrollEnabled = pattern.author == nil // HACK: text view shoud be zero-height when author is nil
            
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            }, completion: nil)
        }
    }
}
