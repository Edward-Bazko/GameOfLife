import Foundation

struct Matrix<Element>  {
    private var grid: [Element]
    
    let width: Int
    let height: Int
    
    init(width: Int, height: Int, fillingWith element: Element) {
        self.width = width
        self.height = height
        grid = Array(repeating: element, count: width * height)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < height && column >= 0 && column < width
    }
    
    subscript(column: Int, row: Int) -> Element {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * width) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * width) + column] = newValue
        }
    }
    
    func enumerateElements(_ enumerator: (Int, Int, Element) -> ()) {
        for row in 0 ..< height {
            for column in 0 ..< width {
                enumerator(column, row, self[column, row])
            }
        }
    }
}


extension Matrix {
    
    mutating func putToCenter(matrix: Matrix<Element>) {
        if matrix.width > width || matrix.height > height {
            print("Matrix doesn't fit")
            return
        }
        
        let centerX = matrix.width / 2
        let centerY = matrix.height / 2
        
        let targetX = width / 2 - centerX
        let targetY = height / 2 - centerY
                
        matrix.enumerateElements { col, row, element in
            self[targetX + col, targetY + row] = element
        }
    }
}
