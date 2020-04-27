import XCTest

class PlaintextDecoderTestCase: XCTestCase {
    let sut = PlaintextDecoder()

    func test_glider_decode() {
        let cells = try! sut.decode(from: glider).cells
        
        XCTAssertEqual(cells.width, 3)
        XCTAssertEqual(cells.height, 3)
        
        XCTAssertEqual(cells[0, 0], Cell.dead)
        XCTAssertEqual(cells[1, 0], Cell.alive)
        XCTAssertEqual(cells[2, 0], Cell.dead)
        
        XCTAssertEqual(cells[0, 1], Cell.dead)
        XCTAssertEqual(cells[1, 1], Cell.dead)
        XCTAssertEqual(cells[2, 1], Cell.alive)

        XCTAssertEqual(cells[0, 2], Cell.alive)
        XCTAssertEqual(cells[1, 2], Cell.alive)
        XCTAssertEqual(cells[2, 2], Cell.alive)
    }
    
    func test_gosper_gun_decode() {
        let cells = try! sut.decode(from: gosper_gun).cells
        
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
        
        XCTAssertEqual(pattern.info, ["Name: Gosper glider gun"])
    }
}

let glider = """
!Name: Glider
!
.O.
..O
OOO
""".data(using: .ascii)!


let gosper_gun = """
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
