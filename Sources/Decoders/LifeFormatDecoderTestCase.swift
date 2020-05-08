import XCTest

class LifeDecoderTestCase: XCTestCase {
    let decoder = LifeDecoder()

    func test_throws() {
        XCTAssertThrowsError(try decoder.decode(from: noHeaderSample)) { error in
            XCTAssertEqual(error as? DecodingError, DecodingError.noHeaderLine)
        }
        XCTAssertThrowsError(try decoder.decode(from: invalid1)) { error in
            XCTAssertEqual(error as? DecodingError, DecodingError.dataCorrupted)
        }
        XCTAssertThrowsError(try decoder.decode(from: invalid2)) { error in
            XCTAssertEqual(error as? DecodingError, DecodingError.dataCorrupted)
        }
    }
    
    func test_glider() {
        let glider = try! decoder.decode(from: gliderPattern)
        assertIsGlider(pattern: glider.loadCells())
    }
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

// http://www.conwaylife.com/wiki/Life_1.06
private let gliderPattern = """
#Life 1.06
0 -1
1 0
-1 1
0 1
1 1
""".data(using: .ascii)!


private let noHeaderSample = """
0 2
1 0
""".data(using: .ascii)!

private let invalid1 = """
#Life 1.06
0
1 0
""".data(using: .ascii)!

private let invalid2 = """
#Life 1.06
0 1
1 0
x
""".data(using: .ascii)!
