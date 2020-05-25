import Foundation

struct Pattern {
    var name: String?
    var author: String?
    var comment: [String]?    
    
    var width: Int = 0
    var height: Int = 0
    
    var loadCells: () -> Matrix<Cell>
}

extension Pattern: Equatable {
    static func == (lhs: Pattern, rhs: Pattern) -> Bool {
        return lhs.name == rhs.name && lhs.author == rhs.author
    }
}
