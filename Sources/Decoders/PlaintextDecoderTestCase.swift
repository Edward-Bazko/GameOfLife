import XCTest

class PlaintextDecoderTestCase: XCTestCase {
    let sut = PlaintextDecoder()
    
    func test_glider_decode() {
        let cells = try! sut.decode(from: glider).loadCells()
        assertIsGlider(pattern: cells)
    }
    
    func test_gosper_gun_decode() {
        let cells = try! sut.decode(from: gosper_gun).loadCells()
        
        XCTAssertEqual(cells.width, 36)
        XCTAssertEqual(cells.height, 9)
        
        let fragment: [Cell] = [.alive, .alive, .dead, .dead,
                                .dead, .dead, .dead, .dead, .dead,
                                .dead, .alive, .dead, .dead, .dead,
                                .alive, .dead, .alive, .alive]
        
        for index in 0..<fragment.count {
            XCTAssertEqual(cells[index, 5], fragment[index])
        }
    }
    
    func test_header() {
        let pattern = try! sut.decode(from: gosper_gun)
        XCTAssertEqual(pattern.comment, ["Name: Gosper glider gun"])
    }
}

private let glider = """
!Name: Glider
!
.O.
..O
OOO
""".data(using: .ascii)!


private let gosper_gun = """
!Name: Gosper glider gun
!
........................O...........
......................O.O...........
............OO......OO............OO
...........O...O....OO............OO
OO........O.....O...OO..............
OO........O...O.OO....O.O...........
..........O.....O.......O...........
...........O...O....................
............OO......................
""".data(using: .ascii)!
