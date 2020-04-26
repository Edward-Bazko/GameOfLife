import UIKit

class UniverseViewController: UIViewController, UniverseViewDataSource {
    private var universeView: UniverseView!
    private var universe: Universe!
    private let cellSide: CGFloat = 7
    
    init() {
        super.init(nibName: nil, bundle: nil)
        refreshUniverse()
    }
    
    var pattern: Pattern = PatternsFactory.makeGosperGliderGun() {
        didSet {
            refreshUniverse()
        }
    }
    
    private func refreshUniverse() {
        let size = UIScreen.main.bounds
        
        var m = Matrix<Cell>(width: Int(size.width / cellSide),
                             height: Int(size.height / cellSide),
                             fillingWith: .dead)
        
        m.put(matrix: pattern.cells, x: 10, y: 10)
        
        universe = Universe(matrix: m)
        universe.onNextGeneration = { [unowned self] in
            self.reloadUniverseView()
        }
        universe.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        universeView = UniverseView(frame: .zero,
                                    columns: universe.matrix.width,
                                    rows: universe.matrix.height,
                                    cellSize: CGSize(width: cellSide, height: cellSide))

        universeView.dataSource = self

        view.addSubview(universeView)
        universeView.fillSuperview()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showPicker))
        universeView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        universe.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        universe.pause()
    }
    
    @objc private func showPicker() {
        let picker = UIAlertController(title: nil, message: "Pick desired pattern", preferredStyle: .actionSheet)
        picker.modalPresentationStyle = .popover
        picker.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        PatternsFactory.allPatterns().forEach { pattern in
            picker.addAction(UIAlertAction(title: pattern.name, style: .default, handler: { _ in
                self.pattern = pattern
            }))
        }
        picker.addAction(UIAlertAction(title: "Random", style: .default, handler: { _ in
            self.universe.seed()
        }))
        picker.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(picker, animated: true, completion: nil)
    }
    
    
    private func reloadUniverseView() {
        if isViewLoaded {
            universeView.reload()
        }
    }
    
    func configure(view: UIView, at column: Int, row: Int) {
        let cell = universe.matrix[column, row]
        view.backgroundColor = cell == .alive ? .green : .white
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

