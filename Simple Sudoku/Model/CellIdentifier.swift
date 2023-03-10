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
    
    private var groupSet: Set<CellIdentifier>? = nil
    private var inlineSet: Set<CellIdentifier>? = nil
    
    var description: String {
        "\(id): (\(row), \(col))"
    }
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
        self.id = row * 9 + col
    }
    
    init(id: Int) {
        self.row = id / 9
        self.col = id % 9
        self.id = id
    }
    
    static func ==(lhs: CellIdentifier, rhs: CellIdentifier) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func getCellGroupSet(cache: Bool = true) -> Set<CellIdentifier> {
        if groupSet != nil { return groupSet! }
        
        var group: Set<CellIdentifier> = []
        
        let rowStart = (row / 3) * 3
        let colStart = (col / 3) * 3
        
        for row in rowStart..<rowStart + 3 {
            for col in colStart..<colStart + 3 {
                group.insert(CellIdentifier(row: row, col: col))
            }
        }
        
        if cache { self.groupSet = group }
        return group
    }
    
    func getCellInlineSet(cache: Bool = true) -> Set<CellIdentifier> {
        if inlineSet != nil { return inlineSet! }
        
        var inline: Set<CellIdentifier> = []
        
        for i in 0..<9 {
            if i != self.col {
                inline.insert(CellIdentifier(row: self.row, col: i))
            }
            
            if i != self.row {
                inline.insert(CellIdentifier(row: i, col: self.col))
            }
        }
        
        if cache { self.inlineSet = inline }
        return inline
    }
}
