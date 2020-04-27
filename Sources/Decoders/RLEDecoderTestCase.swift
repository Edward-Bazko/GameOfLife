import XCTest

class RLEDecoderTestCase: XCTestCase {
    let sut = RLEDecoder()
    
    func test() {
        let pattern = try! sut.decode(from: glider)
        assertIsGlider(pattern: pattern.cells)
        XCTAssertEqual(pattern.comment, ["This is a glider."])
    }
    
    func test_newlines() {
        let pattern = try! sut.decode(from: also_glider)
        assertIsGlider(pattern: pattern.cells)
    }
    
    func test_gosper_glider_gun() {
        let pattern = try! sut.decode(from: gosper_glider_gun)
        let cells = pattern.cells
        XCTAssertEqual(cells.width, 36)
        XCTAssertEqual(cells.height, 9)
        
        let fragment: [Cell] = [.alive, .alive, .dead, .dead,
                                .dead, .dead, .dead, .dead, .dead,
                                .dead, .alive, .dead, .dead, .dead,
                                .alive, .dead, .alive, .alive]
        
        for index in 0..<fragment.count {
            XCTAssertEqual(cells[index, 5], fragment[index])
        }
        
        XCTAssertEqual(pattern.name, "Gosper glider gun")
        XCTAssertEqual(pattern.comment, ["This was the first gun discovered.", "As its name suggests, it was discovered by Bill Gosper."])
    }
}

private let glider = """
#C This is a glider.
x = 3, y = 3
bo$2bo$3o!
""".data(using: .ascii)!

private let also_glider = """
#C This is a glider.
x = 3, y = 3
bo$2bo
$3o
!3o
""".data(using: .ascii)!


private let gosper_glider_gun =
"""
#N Gosper glider gun
#C This was the first gun discovered.
#C As its name suggests, it was discovered by Bill Gosper.
x = 36, y = 9, rule = B3/S23
24bo$22bobo$12b2o6b2o12b2o$11bo3bo4b2o12b2o$2o8bo5bo3b2o$2o8bo3bob2o4b
obo$10bo5bo7bo$11bo3bo$12b2o!
""".data(using: .ascii)!

