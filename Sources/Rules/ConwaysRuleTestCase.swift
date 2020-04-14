import XCTest

class ConwaysRuleTestCase: XCTestCase {
    let rule = ConwaysRule()
    
    func test_live_cell_with_fewer_than_two_live_neighbors_dies() {
        XCTAssert(rule.apply(for: .alive, aliveNeighboursCount: 0) == .dead)
        XCTAssert(rule.apply(for: .alive, aliveNeighboursCount: 1) == .dead)
    }
    
    func test_live_cell_with_two_or_three_live_neighbors_lives() {
        XCTAssert(rule.apply(for: .alive, aliveNeighboursCount: 2) == .alive)
        XCTAssert(rule.apply(for: .alive, aliveNeighboursCount: 3) == .alive)
    }
    
    func test_live_cell_with_more_than_three_live_neighbors_dies() {
        XCTAssert(rule.apply(for: .alive, aliveNeighboursCount: 4) == .dead)
        XCTAssert(rule.apply(for: .alive, aliveNeighboursCount: 5) == .dead)
    }
    
    func test_dead_cell_with_exactly_three_live_neighbors_becomes_a_live_cell() {
        XCTAssert(rule.apply(for: .dead, aliveNeighboursCount: 3) == .alive)
    }
    
    func test_dead_cell_with_more_than_three_live_neighbors_remain_dead() {
        XCTAssert(rule.apply(for: .dead, aliveNeighboursCount: 4) == .dead)
        XCTAssert(rule.apply(for: .dead, aliveNeighboursCount: 5) == .dead)
    }
}
