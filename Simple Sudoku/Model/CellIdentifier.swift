//
//  SquareIdentifier.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import Foundation

class CellIdentifier: Identifiable, Hashable, Equatable, CustomStringConvertible {
    var row: Int
    var col: Int
    var id: Int
    
    var description: String {
        "\(id): (\(row), \(col))"
    }
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
        self.id = CellIdentifier.getId(row: row, col: col)
    }
    
    init(id: Int) {
        self.row = id / 9
        self.col = id % 9
        self.id = id
    }
    
    static func getId(row: Int, col: Int) -> Int {
        row * 9 + col
    }
    
    static func ==(lhs: CellIdentifier, rhs: CellIdentifier) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
