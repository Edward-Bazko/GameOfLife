import XCTest

class SphericLookupTestCase: XCTestCase {
    var matrix = Matrix<Cell>(width: 3, height: 3, fillingWith: .dead)
    let lookup = SphericLookup()
    
    override func setUp() {
        matrix[1, 0] = .alive
        matrix[0, 1] = .alive
        matrix[2, 1] = .alive
        matrix[1, 2] = .alive
    }
    
    func test() {
        assertNeighbours(x: 0, y: 0, equal: [.dead, .dead, .alive, .dead, .alive, .alive, .alive, .dead])
        assertNeighbours(x: 1, y: 0, equal: [.alive, .dead, .dead, .dead, .dead, .dead, .alive, .alive])
        assertNeighbours(x: 2, y: 0, equal: [.dead, .alive, .dead, .alive, .dead, .alive, .dead, .alive])
        
        assertNeighbours(x: 0, y: 1, equal: [.dead, .dead, .alive, .alive, .dead, .dead, .dead, .alive])
        assertNeighbours(x: 1, y: 1, equal: [.alive, .dead, .dead, .alive, .alive, .alive, .dead, .dead])
        assertNeighbours(x: 2, y: 1, equal: [.dead, .alive, .dead, .dead, .alive, .dead, .alive, .dead])
        
        assertNeighbours(x: 0, y: 2, equal: [.alive, .alive, .dead, .dead, .alive, .dead, .dead, .alive])
        assertNeighbours(x: 1, y: 2, equal: [.dead, .alive, .alive, .dead, .dead, .alive, .dead, .dead])
        assertNeighbours(x: 2, y: 2, equal: [.alive, .dead, .alive, .alive, .dead, .dead, .alive, .dead])
    }
    
    func assertNeighbours(x: Int, y: Int, equal expected: [Cell?], file: StaticString = #file, line: UInt = #line) {
        let nb = Neighbours(top: expected[0], topLeft: expected[1], topRight: expected[2], left: expected[3], right: expected[4], bottom: expected[5], bottomLeft: expected[6], bottomRight: expected[7])
        XCTAssertTrue(lookup.neighbours(at: x, y: y, in: matrix) == nb, file: file, line: line)
    }
}
