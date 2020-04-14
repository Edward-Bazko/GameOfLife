import Foundation

class PatternsFactory {
    
    static func makeHeavyweightSpaceShip() -> Matrix<Cell> {
        return loadPatternFrom(fileName: "hwss_106")
    }
    
    static func makeGlider() -> Matrix<Cell> {
        return loadPatternFrom(fileName: "glider")
    }
    
    static func makeGosperGliderGun() -> Matrix<Cell> {
        return loadPatternFrom(fileName: "gosperglidergun_106")
    }
    
    static func makeSwitchEngine() -> Matrix<Cell> {
        return loadPatternFrom(fileName: "switchengine_106")
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
