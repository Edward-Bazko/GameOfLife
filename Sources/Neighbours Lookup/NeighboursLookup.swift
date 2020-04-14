struct Neighbours {
    let top: Cell?
    let topLeft: Cell?
    let topRight: Cell?
    let left: Cell?
    let right: Cell?
    let bottom: Cell?
    let bottomLeft: Cell?
    let bottomRight: Cell?
}

extension Neighbours: Equatable {
    static func == (lhs: Neighbours, rhs: Neighbours) -> Bool {
        return lhs.top == rhs.top &&
            lhs.topLeft == rhs.topLeft &&
            lhs.topRight == rhs.topRight &&
            lhs.left == rhs.left &&
            lhs.right == rhs.right &&
            lhs.bottom == rhs.bottom &&
            lhs.bottomLeft == rhs.bottomLeft &&
            lhs.bottomRight == rhs.bottomRight
    }
}

protocol NeighboursLookup {
    func neighbours(at x: Int, y: Int, in matrix: Matrix<Cell>) -> Neighbours
}

extension NeighboursLookup {
    func neighboursCount(at x: Int, y: Int, in matrix: Matrix<Cell>, where cell: Cell) -> Int {
        var count = 0
        let n = neighbours(at: x, y: y, in: matrix)
        if n.top == cell { count += 1 }
        if n.topLeft == cell { count += 1 }
        if n.topRight == cell { count += 1 }
        if n.left == cell { count += 1 }
        if n.right == cell { count += 1 }
        if n.bottom == cell {count += 1 }
        if n.bottomLeft == cell {count += 1 }
        if n.bottomRight == cell {count += 1 }
        return count
    }
}
