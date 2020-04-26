import XCTest

class LifeFormatDecoderTestCase: XCTestCase {
    let decoder = LifeFormatDecoder()

    func test_throws() {
        XCTAssertThrowsError(try decoder.decode(from: noHeaderSample)) { error in
            XCTAssertEqual(error as? LifeDecodingError, LifeDecodingError.noHeaderLine)
        }
        XCTAssertThrowsError(try decoder.decode(from: invalid1)) { error in
            XCTAssertEqual(error as? LifeDecodingError, LifeDecodingError.dataCorrupted)
        }
        XCTAssertThrowsError(try decoder.decode(from: invalid2)) { error in
            XCTAssertEqual(error as? LifeDecodingError, LifeDecodingError.dataCorrupted)
        }
    }
    
    func test_glider() {
        let glider = try! decoder.decode(from: gliderPattern)
        assertIsGlider(pattern: glider)
    }
    
    func test_loading() {
        let glider = PatternsFactory.makeGlider().cells
        assertIsGlider(pattern: glider)
    }
    
    func assertIsGlider(pattern glider: Matrix<Cell>) {
        XCTAssertEqual(glider.width, 3)
        XCTAssertEqual(glider.height, 3)
        
        XCTAssertEqual(glider[0, 0], .dead)
        XCTAssertEqual(glider[1, 0], .alive)
        XCTAssertEqual(glider[2, 0], .dead)
        
        XCTAssertEqual(glider[0, 1], .dead)
        XCTAssertEqual(glider[1, 1], .dead)
        XCTAssertEqual(glider[2, 1], .alive)
        
        XCTAssertEqual(glider[0, 2], .alive)
        XCTAssertEqual(glider[1, 2], .alive)
        XCTAssertEqual(glider[2, 2], .alive)
    }
}

// http://www.conwaylife.com/wiki/Life_1.06
let gliderPattern = """
#Life 1.06
0 -1
1 0
-1 1
0 1
1 1
""".data(using: .ascii)!


let noHeaderSample = """
0 2
1 0
""".data(using: .ascii)!

let invalid1 = """
#Life 1.06
0
1 0
""".data(using: .ascii)!

let invalid2 = """
#Life 1.06
0 1
1 0
x
""".data(using: .ascii)!
