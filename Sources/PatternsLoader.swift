import Foundation

class PatternsLoader {
    private let plaintextDecoder = PlaintextDecoder()
    private let rleDecoder = RLEDecoder()
    private let lifDecoder = LifeDecoder()
    private let bundle = Bundle(for: PatternsLoader.self)
    private lazy var patternsPath = bundle.resourcePath! + "/Patterns"
    
    var patterns: [Pattern] = []
        
    func load(completion: @escaping () -> ()) {
        patterns.removeAll()
        
        DispatchQueue.global().async {
            let files = try! FileManager.default.contentsOfDirectory(atPath: self.patternsPath)
            self.patterns = files.compactMap(self.parse)
            DispatchQueue.main.async(execute: completion)
        }
    }
    
    private func parse(file: String) -> Pattern? {
        let url = URL(fileURLWithPath: patternsPath + "/" + file)
        let data = try! Data(contentsOf: url)
        print("Decoding \(file)")
        
        var pattern: Pattern?
        switch (file as NSString).pathExtension {
        case "cells":
            pattern = try? self.plaintextDecoder.decode(from: data)
        case "rle":
            pattern = try? self.rleDecoder.decode(from: data)
        case "lif":
            pattern = try? self.lifDecoder.decode(from: data)
        default:
            print("Unknown extension")
        }
        
        if var pattern = pattern {
            if pattern.name == nil {
                pattern.name = file
            }
            return pattern
        }
        else {
            return nil
        }
    }
}
