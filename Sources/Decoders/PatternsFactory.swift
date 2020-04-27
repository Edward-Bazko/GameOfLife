import Foundation

struct Pattern {
    var cells: Matrix<Cell>
    var comment: [String]?
    var name: String?
    var author: String?
}

class PatternsFactory {
    
    static func allPatterns() -> [Pattern] {
        return [makeHeavyweightSpaceShip(), makeGlider(), makeGosperGliderGun(), makeSwitchEngine()]
    }
    
    static func makeHeavyweightSpaceShip() -> Pattern {
        return loadPatternFrom("hwss_106", "Heavyweight Space Ship")
    }
    
    static func makeGlider() -> Pattern {
        return loadPatternFrom("glider", "Glider")
    }

    static func makeGosperGliderGun() -> Pattern {
        return loadPatternFrom("gosperglidergun_106", "Gosper Glider Gun")
    }

    static func makeSwitchEngine() -> Pattern {
        return loadPatternFrom("switchengine_106", "Switch Engine")
    }
        
    static func loadPatternFrom(_ fileName: String, _ name: String) -> Pattern {
        let bundle = Bundle(for: PatternsFactory.self)
        let path = bundle.url(forResource: fileName, withExtension: "lif")!
        let data = try! Data(contentsOf: path)
        let decoder = LifeDecoder()
        var pattern = try! decoder.decode(from: data)
        pattern.name = name
        return pattern
    }
}
