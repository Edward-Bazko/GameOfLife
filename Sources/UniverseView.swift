import UIKit

protocol UniverseViewDataSource: class {
    func configure(view: UIView, at column: Int, row: Int)
}

class UniverseView: UIView {
    let cellSize: CGSize
    let columns: Int
    let rows: Int
    var cells: Matrix<UIView>
    
    weak var dataSource: UniverseViewDataSource?
    
    init(frame: CGRect, columns: Int, rows: Int, cellSize: CGSize) {
        self.cellSize = cellSize
        self.columns = columns
        self.rows = rows
        self.cells = Matrix(width: columns, height: rows, fillingWith: UIView())
        super.init(frame: frame)
        backgroundColor = .white
    }
        
    func reload() {
        cells.enumerateElements { column, row, view in
            dataSource?.configure(view: view, at: column, row: row)
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        guard let _ = newSuperview else { return }
        
        var x: CGFloat = 0, y: CGFloat = 0
        for row in 0...rows - 1 {
            for column in 0...columns - 1 {
                let cell = UIView(frame: CGRect(x: x, y: y, width: cellSize.width, height: cellSize.height))
                cell.layer.drawsAsynchronously = true
                cell.isOpaque = true
                cells[column, row] = cell
                addSubview(cell)
                dataSource?.configure(view: cell, at: column, row: row)
                x += cellSize.width
            }
            x = 0
            y += cellSize.height
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
