struct SphericLookup: NeighboursLookup {
    
    func neighbours(at x: Int, y: Int, in matrix: Matrix<Cell>) -> Neighbours {
        let hasLeft = x != 0
        let hasRight = x < matrix.width - 1
        let hasAbove = y != 0
        let hasBellow = y < matrix.height - 1
        return Neighbours(top: matrix[x,
                                      hasAbove ? y - 1 : matrix.height - 1],
                          
                          topLeft: matrix[hasLeft ? x - 1 : matrix.width - 1,
                                          hasAbove ? y - 1 : matrix.height - 1],
                          
                          topRight: matrix[hasRight ? x + 1 : 0,
                                           hasAbove ? y - 1 : matrix.height - 1],
                          
                          left: matrix[hasLeft ? x - 1 : matrix.width - 1,
                                       y],
                          
                          right: matrix[hasRight ? x + 1 : 0,
                                        y],
                          
                          bottom: matrix[x,
                                         hasBellow ? y + 1 : 0],
                          
                          bottomLeft: matrix[hasLeft ? x - 1 : matrix.width - 1,
                                             hasBellow ? y + 1 : 0],
                          
                          bottomRight: matrix[hasRight ? x + 1 : 0,
                                              hasBellow ? y + 1 : 0])
    }
}
