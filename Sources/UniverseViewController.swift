import UIKit

class UniverseViewController: UIViewController, UniverseViewDataSource {
    var universeView: UniverseView!
    
    private var universe: Universe!
    private let cellSide: CGFloat = 7
    private let aliveColor = UIColor(red: 0, green: 153/255, blue: 51/255, alpha: 1)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        refreshUniverse()
    }
    
    var pattern: Pattern? {
        didSet {
            refreshUniverse()
        }
    }
    
    private func refreshUniverse(seed: Bool = false) {
        let size = UIScreen.main.bounds
        
        let width = Int((size.width / cellSide).rounded(.up))
        let height = Int((size.height / cellSide).rounded(.up))
        
        var matrix = Matrix<Cell>(width: width, height: height, fillingWith: .dead)
        
        if seed {
            matrix.enumerateElements { column, row, _ in
                matrix[column, row] = Bool.random() ? .alive : .dead
            }
        }
        else if let pattern = pattern {
            matrix.putToCenter(matrix: pattern.loadCells())
        }
        
        universe = Universe(matrix: matrix)
        universe.onNextGeneration = { [weak self] in
            self?.reloadUniverseView()
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
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        universe.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        universe.pause()
    }
    
    private func reloadUniverseView() {
        if isViewLoaded {
            universeView.setNeedsDisplay()
            universeView.reload()
        }
    }
    
    func configure(view: UIView, at column: Int, row: Int) {
        let cell = universe.matrix[column, row]
        view.backgroundColor = cell == .alive ? aliveColor : .white
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

