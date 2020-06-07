import UIKit

class PlaygroundViewController: UniverseViewController {
    private let loader = PatternsLoader()
    var patterns: [Pattern] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        loadPatterns()
    }
    
    func setupNavigation() {
        let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(handleForward))
        
        let back = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(handleBackward))
        
        let all = UIBarButtonItem(title: "Patterns", style: .plain, target: self, action: #selector(showPicker))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        setToolbarItems([all, space, back, forward], animated: false)
        navigationController?.isNavigationBarHidden = true
    }
    
    func loadPatterns() {
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
            self.navigationController?.isToolbarHidden = false
            
            UIView.animate(withDuration: 0.25, animations: {
                self.universeView.alpha = 1
                activity.alpha = 0
                self.handleForward()
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
}

