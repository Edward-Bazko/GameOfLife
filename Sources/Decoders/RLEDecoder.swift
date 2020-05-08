// https://www.conwaylife.com/wiki/Run_Length_Encoded

import Foundation

class RLEDecoder {
    func decode(from data: Data) throws -> Pattern {
        guard let string = String(data: data, encoding: .ascii) else {
            throw DecodingError.dataCorrupted
        }
        return try DecodingItem(string: string).decode()
    }
}

private class DecodingItem {
    let lines: [String]
    var cursorLine = 0
    var cells: Matrix<Cell>?
    var comment: [String] = []
    var name: String?
    var author: String?
    
    init(string: String) {
        self.lines = string.components(separatedBy: .newlines).filter { !$0.isEmpty }
    }
    
    func decode() throws -> Pattern {
        scanHeader()
        
        return Pattern(name: name, author: author, comment: comment, loadCells: {
            try! self.scanDimensions()
            try! self.scanSequence()
            return self.cells!
        })
    }
    
    private func scanHeader() {
        for (index, line) in lines.enumerated() {
            
            cursorLine = index
            
            if line.starts(with: "#N ") {
                name = String(line.dropFirst(3))
            }
            else if line.starts(with: "#C ") || line.starts(with: "#c ") {
                comment.append(String(line.dropFirst(3)))
            }
            else if line.starts(with: "#O ") {
                author = String(line.dropFirst(3))
            }
            else {
                break
            }
        }
    }
    
    private func scanDimensions() throws {
        let scanner = Scanner(string: lines[cursorLine])
        
        _ = scanner.scanString("x = ")
        guard let width = scanner.scanInt() else { throw DecodingError.dataCorrupted }
        
        _ = scanner.scanString(",")
        _ = scanner.scanString("y = ")
        
        guard let height = scanner.scanInt() else { throw DecodingError.dataCorrupted }
        
        cells = Matrix<Cell>(width: width, height: height, fillingWith: .dead)
        
        cursorLine += 1
    }
    
    private func scanSequence() throws {
        let line = lines.dropFirst(cursorLine).joined()
        
        guard let endIndex = line.firstIndex(of: "!") else { throw DecodingError.dataCorrupted }
        
        let seq = String(line.prefix(upTo: endIndex))
        
        let scanner = Scanner(string: seq)
        var rowIndex = 0
        var columnIndex = 0
        
        while !scanner.isAtEnd {
            
            var count = 1
            var cell: Cell = .dead
            
            if let c = scanner.scanInt() {
                count = c
            }
            
            if let char = scanner.scanCharacter() {
                switch char {

                case "$":
                    rowIndex += 1
                    columnIndex = 0
                    continue
                    
                case "b": cell = .dead
                
                case "o": fallthrough
                default:                
                    cell = .alive
                }
                
            }
            
            for x in 0..<count {
                cells![columnIndex + x, rowIndex] = cell
            }
            
            columnIndex += count
        }
    }
}
