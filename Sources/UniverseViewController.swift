import UIKit

class UniverseViewController: UIViewController, UniverseViewDataSource {
    private var universeView: UniverseView!
    private let universe: Universe
    private let cellSide: CGFloat = 7
    
    init() {
        let size = UIScreen.main.bounds
        
        var m = Matrix<Cell>(width: Int(size.width / cellSide),
                             height: Int(size.height / cellSide),
                             fillingWith: .dead)
        
        m.put(matrix: PatternsFactory.makeGosperGliderGun(), x: 10, y: 10)
        
        universe = Universe(matrix: m, lookup: SphericLookup())
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        universeView = UniverseView(frame: .zero,
                                    columns: universe.matrix.width,
                                    rows: universe.matrix.height,
                                    cellSize: CGSize(width: cellSide, height: cellSide))
        view = universeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        universeView.dataSource = self
        universe.onNextGeneration = { [unowned self] in
            self.universeView.reload()
        }
        universe.play()
    }
    
    func configure(view: UIView, at column: Int, row: Int) {
        let cell = universe.matrix[column, row]
        view.backgroundColor = cell == .alive ? .gray : .white
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

