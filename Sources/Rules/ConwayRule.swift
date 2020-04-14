class ConwaysRule: Rule {
    func apply(for cell: Cell, aliveNeighboursCount: Int) -> Cell {
        switch cell {
        case .alive where aliveNeighboursCount < 2:
            return .dead
        case .alive where aliveNeighboursCount > 3:
            return .dead
        case .dead where aliveNeighboursCount == 3:
            return .alive
        default:
            return cell
        }
    }
}
