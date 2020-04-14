import XCTest

class UniverseTestCase: XCTestCase {

    // Input:
    //
    // | dead | alive | alive |
    // | dead | alive | dead  |
    // | dead | alive | dead  |
    func test_universe_tick_example() {
        var matrix: Matrix<Cell> = Matrix(width: 3, height: 3, fillingWith: .dead)
        matrix[1, 0] = .alive
        matrix[2, 0] = .alive
        matrix[1, 1] = .alive
        matrix[1, 2] = .alive
        let universe = Universe(matrix: matrix, rule: ConwaysRule(), lookup: BoundedLookup())
        
        universe.tick()
        
        XCTAssert(universe.matrix[0, 0] == .dead)
        XCTAssert(universe.matrix[1, 0] == .alive)
        XCTAssert(universe.matrix[2, 0] == .alive)
        
        XCTAssert(universe.matrix[0, 1] == .alive)
        XCTAssert(universe.matrix[1, 1] == .alive)
        XCTAssert(universe.matrix[2, 1] == .dead)
        
        XCTAssert(universe.matrix[0, 2] == .dead)
        XCTAssert(universe.matrix[1, 2] == .dead)
        XCTAssert(universe.matrix[2, 2] == .dead)
    }
}

