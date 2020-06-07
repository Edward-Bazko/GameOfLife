import Foundation

enum Cell {
    case alive
    case dead
}

class Universe {
    private let rule: Rule
    private var lookup: NeighboursLookup
    private var paused = true
    private(set) var matrix: Matrix<Cell>
    private var timer: Timer?
    
    var onNextGeneration: () -> () = {}
    
    init(matrix: Matrix<Cell>,
         rule: Rule = ConwaysRule(),
         lookup: NeighboursLookup = SphericLookup()) {
        self.matrix = matrix
        self.rule = rule
        self.lookup = lookup
    }
    
    func play() {
        guard paused else { return }
        paused = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }
    
    func pause() {
        paused = true
        timer?.invalidate()
        timer = nil
    }
        
    func tick() {
        var generation = matrix
        matrix.enumerateElements { column, row, cell in
            let aliveCount = lookup.neighboursCount(at: column, y: row, in: matrix, where: .alive)
            generation[column, row] = rule.apply(for: cell, aliveNeighboursCount: aliveCount)
        }
        matrix = generation
        onNextGeneration()
    }
}
