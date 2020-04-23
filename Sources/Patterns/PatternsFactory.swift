import Foundation

struct Pattern {
    var name: String
    var cells: Matrix<Cell>
}

class PatternsFactory {
    
    static func allPatterns() -> [Pattern] {
        return [makeHeavyweightSpaceShip(), makeGlider(), makeGosperGliderGun(), makeSwitchEngine()]
    }
    
    static func makeHeavyweightSpaceShip() -> Pattern {
        return Pattern(name: "Heavyweight Space Ship", cells: loadPatternFrom(fileName: "hwss_106"))
    }
    
    static func makeGlider() -> Pattern {
        return Pattern(name: "Glider", cells: loadPatternFrom(fileName: "glider"))
    }
    
    static func makeGosperGliderGun() -> Pattern {
        return Pattern(name: "Gosper Glider Gun", cells: loadPatternFrom(fileName: "gosperglidergun_106"))
    }
    
    static func makeSwitchEngine() -> Pattern {
        return Pattern(name: "Switch Engine", cells: loadPatternFrom(fileName: "switchengine_106"))
    }
    
    static func loadPatternFrom(fileName: String) -> Matrix<Cell> {
        let bundle = Bundle(for: PatternsFactory.self)
        let path = bundle.url(forResource: fileName, withExtension: "lif")!
        let data = try! Data(contentsOf: path)
        let decoder = LifeFormatDecoder()
        let matrix = try! decoder.decode(from: data)
        return matrix
    }
}
