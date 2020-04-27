// http://www.conwaylife.com/wiki/Life_1.06

import Foundation

enum DecodingError: Error {
    case dataCorrupted
    case noHeaderLine
}

class LifeDecoder {
    func decode(from data: Data) throws -> Pattern {
        guard let string = String(data: data, encoding: .ascii) else {
            throw DecodingError.dataCorrupted
        }
        
        let lines = string.components(separatedBy: .newlines).filter { !$0.isEmpty }
        if lines.count == 0 {
            throw DecodingError.dataCorrupted
        }
        
        if lines.first?.starts(with: "#Life 1.06") == false {
            throw DecodingError.noHeaderLine
        }
        
        var tuples = [(Int, Int)]()
        var maxX = 0; var minX = 0
        var maxY = 0; var minY = 0
        
        for line in lines.dropFirst() {
            if line.count == 0 { continue }
            let scanner = Scanner(string: line)
            var x: Int = 0; var y: Int = 0
            if scanner.scanInt(&x) == false {
                throw DecodingError.dataCorrupted
            }
            if scanner.scanInt(&y) == false {
                throw DecodingError.dataCorrupted
            }
            tuples.append((x, y))
            maxX = max(maxX, x); minX = min(minX, x)
            maxY = max(maxY, y); minY = min(minY, y)
        }
        
        let width = (maxX + abs(minX)) + 1
        let height = (maxY + abs(minY)) + 1
        
        var m = Matrix(width: width, height: height, fillingWith: Cell.dead)
        
        for (x, y) in tuples {
            m[x + abs(minX), y + abs(minY)] = .alive
        }
        
        return Pattern(cells: m)
    }
}


