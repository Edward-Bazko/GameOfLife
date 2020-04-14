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
    
    mutating func put(matrix: Matrix<Element>, x: Int, y: Int) {
        assert(x + matrix.width <= width, "Matrix is too wide")
        assert(y + matrix.height <= height, "Matrix is too high")
        matrix.enumerateElements { col, row, element in
            self[x + col, y + row] = element
        }
    }
}
