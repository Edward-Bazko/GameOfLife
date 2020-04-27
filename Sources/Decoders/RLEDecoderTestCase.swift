import XCTest

class RLEDecoderTestCase: XCTestCase {
    let sut = RLEDecoder()
    
    func test() {
        let pattern = try! sut.decode(from: glider)
        let cells = pattern.cells
        XCTAssertEqual(cells.width, 3)
        XCTAssertEqual(cells.height, 3)
        assertIsGlider(pattern: pattern.cells)
    }
}

private let glider = """
#C This is a glider.
x = 3, y = 3
bo$2bo$3o!
""".data(using: .ascii)!
