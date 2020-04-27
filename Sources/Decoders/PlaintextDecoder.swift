// https://www.conwaylife.com/wiki/Plaintext

import Foundation

struct PlaintextPattern {
    let cells: Matrix<Cell>
    let info: [String]
}

class PlaintextDecoder {
    func decode(from data: Data) throws -> PlaintextPattern {
        guard let string = String(data: data, encoding: .ascii) else {
            throw LifeDecodingError.dataCorrupted
        }
        
        let lines = string.components(separatedBy: .newlines)
        if lines.count == 0 {
            throw LifeDecodingError.dataCorrupted
        }
        
        var parsed = [[Cell]]()
        var info: [String] = []
        var maxWidth = 0
        
        for line in lines {
            if line.starts(with: "!") {
                if line.count != 1 {
                    info.append(String(line.dropFirst()))
                }
            }
            else {
                parsed.append(line.map { char in char == "." ? Cell.dead : Cell.alive })
                maxWidth = max(maxWidth, line.count)
            }
        }

        var matrix = Matrix<Cell>(width: maxWidth, height: parsed.count, fillingWith: .dead)
        
        for (rowIndex, rowCells) in parsed.enumerated() {
            for (columnIndex, cell) in rowCells.enumerated() {
                matrix[columnIndex, rowIndex] = cell
            }
        }
        
        return PlaintextPattern(cells: matrix, info: info)
    }
}
