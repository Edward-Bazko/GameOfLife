import XCTest

class RLEDecoderTestCase: XCTestCase {
    let sut = RLEDecoder()
    
    func test() {
        let pattern = try! sut.decode(from: glider)
        assertIsGlider(pattern: pattern.loadCells())
        XCTAssertEqual(pattern.comment, ["This is a glider."])
    }
    
    func test_newlines() {
        let pattern = try! sut.decode(from: also_glider)
        assertIsGlider(pattern: pattern.loadCells())
    }
    
    func test_gosper_glider_gun() {
        let pattern = try! sut.decode(from: gosper_glider_gun)
        let cells = pattern.loadCells()
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
    
    func test_p15bumber() {
        _ = try! sut.decode(from: p15bumper)
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


private let p15bumper = """
#N p15bumper.rle\r\n#O Tanner Jacobi, 2016\r\n#C http://conwaylife.com/wiki/P15_bumper\r\n#C http://www.conwaylife.com/patterns/p15bumper.rle\r\nx = 72, y = 64, rule = B3/S23\r\n71bo$69b2o$70b2o9$59bo$58bo$58b3o17$b2o38bo$2o37b2o$2bo37b2o9$12b2o15b\r\no$12bobo13bo$12bo15b3o9$6b2o4b2o6b2o$5bo2bo2bo2bo4bo2bo$5bo2bo2bo2bo5b\r\nobo$6bob4obo7bo$8bo2bo$25b2o$25bo$5b2o6b2o11b3o$3bo4bo2bo4bo11bo$3bo4b\r\no2bo4bo$3bo4bo2bo4bo$5b2o6b2o!
""".data(using: .ascii)!
