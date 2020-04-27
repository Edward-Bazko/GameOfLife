import Foundation

enum LifeDecodingError: Error {
    case dataCorrupted
    case noHeaderLine
}

class LifeFormatDecoder {
    func decode(from data: Data) throws -> Matrix<Cell> {
        guard let string = String(data: data, encoding: .ascii) else {
            throw LifeDecodingError.dataCorrupted
        }
        
        let lines = string.components(separatedBy: .newlines)
        if lines.count == 0 {
            throw LifeDecodingError.dataCorrupted
        }
        
        if lines.first?.starts(with: "#Life 1.06") == false {
            throw LifeDecodingError.noHeaderLine
        }
        
        var tuples = [(Int, Int)]()
        var maxX = 0; var minX = 0
        var maxY = 0; var minY = 0
        
        for line in lines.dropFirst() {
            if line.count == 0 { continue }
            let scanner = Scanner(string: line)
            var x: Int = 0; var y: Int = 0
            if scanner.scanInt(&x) == false {
                throw LifeDecodingError.dataCorrupted
            }
            if scanner.scanInt(&y) == false {
                throw LifeDecodingError.dataCorrupted
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
        
        return m
    }
}


