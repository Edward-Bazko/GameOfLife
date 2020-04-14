struct BoundedLookup: NeighboursLookup {
    
    func neighbours(at x: Int, y: Int, in matrix: Matrix<Cell>) -> Neighbours {
        let hasLeft = x != 0
        let hasRight = x < matrix.width - 1
        let hasAbove = y != 0
        let hasBellow = y < matrix.height - 1
        return Neighbours(top: hasAbove ? matrix[x, y - 1] : nil,
                          topLeft: hasAbove && hasLeft ? matrix[x - 1, y - 1] : nil,
                          topRight: hasAbove && hasRight ? matrix[x + 1, y - 1] : nil,
                          left: hasLeft ? matrix[x - 1, y] : nil,
                          right: hasRight ? matrix[x + 1, y] : nil,
                          bottom: hasBellow ? matrix[x, y + 1] : nil,
                          bottomLeft: hasBellow && hasLeft ? matrix[x - 1, y + 1] : nil,
                          bottomRight: hasBellow && hasRight ? matrix[x + 1, y + 1] : nil)
    }
}
