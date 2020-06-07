import UIKit

class PatternsListViewController: UITableViewController {
    var patterns: [Pattern] = []
    var onPatternSelected: (Pattern) -> Void = { _ in }
    var current: Pattern?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "Cell")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleClose))
    }
     
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let current = current, let row = patterns.firstIndex(of: current) {
            let indexPath = IndexPath(row: row, section: 0)
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patterns.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pattern = patterns[indexPath.row]
        cell.textLabel?.text = pattern.name
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = self.detailText(for: pattern)
        cell.detailTextLabel?.numberOfLines = 0
        
        if pattern == current {
            cell.accessoryType = .checkmark
            cell.backgroundColor = UIColor.yellow.withAlphaComponent(0.2)
        }
        else {
            cell.accessoryType = .none
            cell.backgroundColor = nil
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pattern = patterns[indexPath.row]
        current = pattern
        onPatternSelected(pattern)
    }
    
    @objc private func handleClose() {
        dismiss(animated: true, completion: nil)
    }
    
    private func detailText(for pattern: Pattern) -> String? {
        var detailText: String? = nil
        if let author = pattern.author {
            detailText = author
        }
        if let comment = pattern.comment?.joined(separator: "\n") {
            detailText?.append("\n" + comment)
        }
        return detailText
    }
}

class DetailTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
