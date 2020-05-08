import Foundation

struct Pattern {
    var name: String?
    var author: String?
    var comment: [String]?    
    var loadCells: () -> Matrix<Cell>
}
