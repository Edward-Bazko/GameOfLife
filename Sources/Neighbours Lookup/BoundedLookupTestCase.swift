import XCTest

class BoundedLookupTestCase: XCTestCase {
    let matrix = Matrix<Cell>(width: 3, height: 3, fillingWith: .dead)
    let lookup = BoundedLookup()
    
    func test() {
        assertNeighbours(x: 0, y: 0, equal: [nil, nil, nil, nil, .dead, .dead, nil, .dead])
        assertNeighbours(x: 1, y: 0, equal: [nil, nil, nil, .dead, .dead, .dead, .dead, .dead])
        assertNeighbours(x: 2, y: 0, equal: [nil, nil, nil, .dead, nil, .dead, .dead, nil])
        
        assertNeighbours(x: 0, y: 1, equal: [.dead, nil, .dead, nil, .dead, .dead, nil, .dead])
        assertNeighbours(x: 1, y: 1, equal: [.dead, .dead, .dead, .dead, .dead, .dead, .dead, .dead])
        assertNeighbours(x: 2, y: 1, equal: [.dead, .dead, nil, .dead, nil, .dead, .dead, nil])
        
        assertNeighbours(x: 0, y: 2, equal: [.dead, nil, .dead, nil, .dead, nil, nil, nil])
        assertNeighbours(x: 1, y: 2, equal: [.dead, .dead, .dead, .dead, .dead, nil, nil, nil])
        assertNeighbours(x: 2, y: 2, equal: [.dead, .dead, nil, .dead, nil, nil, nil, nil])
    }
    
    func assertNeighbours(x: Int, y: Int, equal expected: [Cell?], file: StaticString = #file, line: UInt = #line) {
        let nb = Neighbours(top: expected[0], topLeft: expected[1], topRight: expected[2], left: expected[3], right: expected[4], bottom: expected[5], bottomLeft: expected[6], bottomRight: expected[7])
        XCTAssertTrue(lookup.neighbours(at: x, y: y, in: matrix) == nb, file: file, line: line)
    }
}
