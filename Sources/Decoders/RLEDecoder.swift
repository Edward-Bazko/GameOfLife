// https://www.conwaylife.com/wiki/Run_Length_Encoded

import Foundation

struct RLEPattern {
    let cells: Matrix<Cell>
}

class RLEDecoder {
    func decode(from data: Data) throws -> RLEPattern {
        guard let string = String(data: data, encoding: .ascii) else {
            throw LifeDecodingError.dataCorrupted
        }
        return try DecodingItem(string: string).decode()
    }
}

private class DecodingItem {
    let string: String
    let lines: [String]
    let scanner: Scanner
    var width: Int = 0
    var height: Int = 0
    var cursorLine = 0
    var cells: Matrix<Cell>?
    
    init(string: String) {
        self.string = string
        self.scanner = Scanner(string: string)
        self.lines = string.components(separatedBy: .newlines)
    }
    
    func decode() throws -> RLEPattern {
        try scanHeader()
        try scanDimensions()
        try scanSequence()
        return RLEPattern(cells: cells!)
    }
    
    private func scanHeader() throws {
        for (index, line) in lines.enumerated() {
            
            cursorLine = index
            
            if line.starts(with: "#") {
            
            }
            else {
                break
            }
        }
    }
    
    private func scanDimensions() throws {
        let scanner = Scanner(string: lines[cursorLine])
        
        _ = scanner.scanString("x = ")
        guard let width = scanner.scanInt() else { throw LifeDecodingError.dataCorrupted }
        
        _ = scanner.scanString(",")
        _ = scanner.scanString("y = ")
        
        guard let height = scanner.scanInt() else { throw LifeDecodingError.dataCorrupted }
        
        cells = Matrix<Cell>(width: width, height: height, fillingWith: .dead)
        
        cursorLine += 1
    }
    
    private func scanSequence() throws {
        let line = lines[cursorLine]
        guard let endIndex = line.firstIndex(of: "!") else { throw LifeDecodingError.dataCorrupted }
        let seq = String(line.prefix(upTo: endIndex))
        
        let scanner = Scanner(string: seq)
        var rowIndex = 0
        var columnIndex = 0
        var done = false
        
        while !scanner.isAtEnd, !done {

            var count = 1
            var cell: Cell = .dead
            
            if let c = scanner.scanInt() {
                count = c
            }
            
            if let char = scanner.scanCharacter() {
                switch char {
                case "b": cell = .dead
                case "o": cell = .alive
                
                case "$":
                    rowIndex += 1
                    columnIndex = 0
                    continue
                
                case "!":
                    done = true
                    continue
                    
                default: throw LifeDecodingError.dataCorrupted
                }
            }
            
            for x in 0..<count {
                cells![columnIndex + x, rowIndex] = cell
            }
            
            columnIndex += count
        }
    }
}
