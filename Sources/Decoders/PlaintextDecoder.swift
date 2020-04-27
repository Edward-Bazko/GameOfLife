// https://www.conwaylife.com/wiki/Plaintext

import Foundation

class PlaintextDecoder {
    
    func decode(from data: Data) throws -> Pattern {
        guard let string = String(data: data, encoding: .ascii) else {
            throw DecodingError.dataCorrupted
        }
        
        let lines = string.components(separatedBy: .newlines).filter { !$0.isEmpty }
        if lines.count == 0 {
            throw DecodingError.dataCorrupted
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
        
        return Pattern(cells: matrix, comment: info)
    }
}
