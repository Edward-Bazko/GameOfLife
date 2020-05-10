import UIKit

class PlaygroundViewController: UniverseViewController {
    private let loader = PatternsLoader()
    var patterns: [Pattern] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(handleForward))
        
        let back = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(handleBackward))
        
        setToolbarItems([back, forward], animated: false)
        navigationController?.isNavigationBarHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showPicker))
        universeView.addGestureRecognizer(tap)
        
        loader.load(completion: {
            self.patterns = self.loader.patterns
            self.navigationController?.isToolbarHidden = false
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

