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
    
    var onNextGeneration: () -> () = {}
    
    init(matrix: Matrix<Cell>,
         rule: Rule = ConwaysRule(),
         lookup: NeighboursLookup = BoundedLookup()) {
        self.matrix = matrix
        self.rule = rule
        self.lookup = lookup
    }
    
    func play() {
        guard paused else { return }
        paused = false
        DispatchQueue.global().async {
            while !self.paused {
                self.tick()
                DispatchQueue.main.sync {
                    self.onNextGeneration()
                }
            }
        }
    }
    
    func pause() {
        paused = true
    }
    
    func seed() {
        matrix.enumerateElements { column, row, _ in
            matrix[column, row] = Bool.random() ? .alive : .dead
        }
    }
    
    func tick() {
        var generation = matrix
        matrix.enumerateElements { column, row, cell in
            let aliveCount = lookup.neighboursCount(at: column, y: row, in: matrix, where: .alive)
            generation[column, row] = rule.apply(for: cell, aliveNeighboursCount: aliveCount)
        }
        matrix = generation
    }
}
