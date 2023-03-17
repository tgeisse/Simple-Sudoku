//
//  CellGroup.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/12/23.
//

import Foundation

extension CellIdentifier {
    var groupSet: Set<CellIdentifier> { CellGroup.shared.getGroup(self) }
    var inlineSet: Set<CellIdentifier> { CellGroup.shared.getInline(self) }
    var allImpactedSet: Set<CellIdentifier> { CellGroup.shared.getAllImpactedCells(self) }
}

class CellGroup {
    // make it a singleton
    static var shared = CellGroup()
    private init() {}
    
    private let cells = (0..<81).map { CellIdentifier(id: $0) }
    private var groupSets: [CellIdentifier: Set<CellIdentifier>] = [:]
    private var inlineSets: [CellIdentifier: Set<CellIdentifier>] = [:]
    private var allImpactedCellSets: [CellIdentifier: Set<CellIdentifier>] = [:]
    
    // MARK: - Group Set
    func getGroup(row: Int, col: Int) -> Set<CellIdentifier> {
        getGroup(cellId: CellIdentifier.getId(row: row, col: col))
    }
    
    func getGroup(cellId: Int) -> Set<CellIdentifier> {
        getGroup(cells[cellId])
    }
    
    func getGroup(_ cell: CellIdentifier) -> Set<CellIdentifier> {
        let startRow = cell.row - cell.row % 3
        let startCol = cell.col - cell.col % 3
        
        let mainCell = cells[CellIdentifier.getId(row: startRow, col: startCol)]
        
        if let cached = groupSets[mainCell] {
            return cached
        }
        
        var groupSet: Set<CellIdentifier> = []
        
        for row in startRow..<startRow + 3 {
            for col in startCol..<startCol + 3 {
                groupSet.insert(cells[CellIdentifier.getId(row: row, col: col)])
            }
        }
        
        groupSets[mainCell] = groupSet
        return groupSet
    }
    
    // MARK: - Inline set
    func getInline(row: Int, col: Int) -> Set<CellIdentifier> {
        getInline(cellId: CellIdentifier.getId(row: row, col: col))
    }
    
    func getInline(cellId: Int) -> Set<CellIdentifier> {
        getInline(cells[cellId])
    }
    
    func getInline(_ cell: CellIdentifier) -> Set<CellIdentifier> {
        if let cached = inlineSets[cell] {
            return cached
        }
        
        var inlineSet: Set<CellIdentifier> = []
        
        for i in 0..<9 {
            inlineSet.insert(cells[CellIdentifier.getId(row: cell.row, col: i)])
            inlineSet.insert(cells[CellIdentifier.getId(row: i, col: cell.col)])
        }
        
        inlineSets[cell] = inlineSet
        return inlineSet
    }
    
    // MARK: - All Impacted Cells
    func getAllImpactedCells(row: Int, col: Int) -> Set<CellIdentifier> {
        getAllImpactedCells(cellId: CellIdentifier.getId(row: row, col: col))
    }
    
    func getAllImpactedCells(cellId: Int) -> Set<CellIdentifier> {
        getAllImpactedCells(cells[cellId])
    }
    
    func getAllImpactedCells(_ cell: CellIdentifier) -> Set<CellIdentifier> {
        if let cached = allImpactedCellSets[cell] {
            return cached
        }
        
        let groupSet = getGroup(cell)
        let inlineSet = getInline(cell)
        let allImpacted = groupSet.union(inlineSet)
        
        allImpactedCellSets[cell] = allImpacted
        return allImpacted
    }
}
