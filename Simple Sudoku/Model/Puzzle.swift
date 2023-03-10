//
//  Puzzle.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import Foundation

class Puzzle: ObservableObject {
    var solution = [Int](repeating: -1, count: 81)
    var given: [Int?] = []
    
    init(difficulty: PuzzleDifficulty) {
        generateSolution()
        self.given = generateUniquePuzzle(difficulty)
    }
    
    private func generateUniquePuzzle(_ difficulty: PuzzleDifficulty) -> [Int?] {
        let givenCells = difficulty.cellsGiven.randomElement()!
        
        var given = solution
        var emptyCells: [CellIdentifier] = []
        var filledCells = Set((0..<81).map { CellIdentifier(id: $0) })
        
        while filledCells.count > givenCells {
            // pick a random element and remove it
            let randCell = filledCells.randomElement()!
            
            given[randCell.id] = 0
            emptyCells.append(randCell)
            
            if solve(emptyCells, &given, true) != 1 {
                emptyCells.removeLast()
                given[randCell.id] = solution[randCell.id]
            } else {
                filledCells.remove(randCell)
            }
        }
        
        return given.map { $0 == 0 ? nil : $0 }
    }
    
    private func generateSolution() {
        let emptyCells = (0..<81).map { CellIdentifier(id: $0) }
        var solution = [Int](repeating: 0, count: 81)
        
        solve(emptyCells, &solution, false)
        
        self.solution = solution
    }
    
    @discardableResult
    private func solve(_ emptyCells: [CellIdentifier], _ solution: inout [Int], _ checkUnique: Bool) -> Int {
        if emptyCells.isEmpty { return 0 }
        
        var localEmptyCells = emptyCells
        let myCell = localEmptyCells.removeLast()
        var valueSet = Set([1,2,3,4,5,6,7,8,9])
        let cellsImpactingMe = myCell.getCellGroupSet().union(myCell.getCellInlineSet())
        
        var solutionCount = 0
        
        while let value = valueSet.randomElement(), ((checkUnique && solutionCount < 2) || solutionCount < 1) {
            valueSet.remove(value)
            if !cellsImpactingMe.filter({ solution[$0.id] == value }).isEmpty {
                continue
            }
            
            solution[myCell.id] = value
            
            if localEmptyCells.isEmpty {
                return 1
            }
            
            solutionCount += solve(localEmptyCells, &solution, checkUnique)
        }
        
        if checkUnique || solutionCount < 1 {
            solution[myCell.id] = 0
        }
        
        return solutionCount
    }
    
    /*
    private func generatePuzzle() {
        let cellOptions = (0..<81).reduce(into: [:]) { $0[CellIdentifier(id: $1)] = Set([1,2,3,4,5,6,7,8,9]) }
        var solution = [Int](repeating: -1, count: 81)
        
        solve(cellOptions: cellOptions,
              solution: &solution,
              countUnique: false)
        
        self.solution = solution
    }
    
    @discardableResult
    private func solve(cellOptions: [CellIdentifier: Set<Int>], solution: inout [Int], countUnique: Bool) -> Int {
        guard let randomCell = cellOptions.randomElement() else { return 0 }
        
        let myCellId = randomCell.key
        var myPossibleValues = randomCell.value
        var solutionCount = 0
        
        let updateCellsOnPickedValue = myCellId.getCellGroupSet().union(myCellId.getCellInlineSet())
        
        while !myPossibleValues.isEmpty && (solutionCount < 1 || countUnique) {
            let value = myPossibleValues.randomElement()!
            myPossibleValues.remove(value)
            
            var nextCellOptions = cellOptions
            nextCellOptions[myCellId] = nil
            
            solution[myCellId.id] = value
            
            if nextCellOptions.isEmpty {
                // this is a solution
                return 1
            }
            
            var noSolution = false
            updateCellsOnPickedValue.forEach {
                nextCellOptions[$0]?.remove(value)
                noSolution = noSolution || (nextCellOptions[$0]?.isEmpty ?? false)
            }
            if noSolution { continue }
            
            solutionCount += solve(cellOptions: nextCellOptions,
                                   solution: &solution,
                                   countUnique: countUnique)
        }
        
        return solutionCount
    }
     */
}


