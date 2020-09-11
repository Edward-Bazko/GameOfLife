import UIKit

class PlaygroundViewController: UniverseViewController {
    private let loader = PatternsLoader()
    private var patterns: [Pattern] = []
    private let infoView = PatternInfoView().autolayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupInfoView()
        loadPatterns()
    }
    
    private func setupInfoView() {
        view.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupNavigation() {
        let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(handleForward))
        let back = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(handleBackward))
        let all = UIBarButtonItem(title: "All Patterns", style: .plain, target: self, action: #selector(showPicker))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        setToolbarItems([all, space, back, forward], animated: false)
        navigationController?.isNavigationBarHidden = true
    }
    
    override var pattern: Pattern? {
        didSet {
            if let pattern = pattern {
                infoView.renderPattern(pattern)
            }
        }
    }
    
    private func loadPatterns() {
        universeView.alpha = 0.2
        let activity = UIActivityIndicatorView(style: .large)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        view.addSubview(activity)
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        
        loader.load(completion: {
            self.patterns = self.loader.patterns
            self.navigationController?.setToolbarHidden(false, animated: true)
            UIView.animate(withDuration: 0.25, animations: {
                self.universeView.alpha = 1
                activity.alpha = 0
                self.setRandomPattern()
            })
        })
    }
    
    var index = 0 {
        didSet {
            pattern = patterns[index]
        }
    }
    
    @objc private func showPicker() {
        let list = PatternsListViewController(style: .insetGrouped)
        list.patterns = self.patterns
        list.current = pattern
        list.onPatternSelected = { [unowned self] pattern in
            self.pattern = pattern
            self.dismiss(animated: true, completion: nil)
        }
        self.present(UINavigationController(rootViewController: list),
                     animated: true, completion: nil)
    }
    
    @objc func handleForward() {
        self.index = patterns.index(after: index)
    }
    
    @objc func handleBackward() {
        self.index = patterns.index(before: index)
    }
    
    func setRandomPattern() {
        self.index = Int.random(in: 0..<patterns.count)
    }
}

