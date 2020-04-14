protocol Rule {
    func apply(for cell: Cell, aliveNeighboursCount: Int) -> Cell
}
