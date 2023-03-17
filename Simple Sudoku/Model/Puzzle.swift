//
//  Puzzle.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import Foundation

class Puzzle: ObservableObject {
    var solution: [Int] = []
    var given: [Int?] = []
    let difficulty: PuzzleDifficulty
    
    init(difficulty: PuzzleDifficulty) {
        self.difficulty = difficulty
    }
    
    func generate() {
        solution = generateSolution()
        given = generateUniquePuzzle(difficulty)
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
            
            if solve(emptyCells: emptyCells, solution: &given, checkUnique: true) != 1 {
                emptyCells.removeLast()
                given[randCell.id] = solution[randCell.id]
            } else {
                filledCells.remove(randCell)
            }
        }
        
        return given.map { $0 == 0 ? nil : $0 }
    }
    
    private func generateSolution() -> [Int] {
        let emptyCells = (0..<81).map { CellIdentifier(id: $0) }
        var solution = [Int](repeating: 0, count: 81)
        
        let _ = solve(emptyCells: emptyCells,
                      solution: &solution,
                      checkUnique: false)
        
        return solution
    }
    
    private func solve(emptyCells: [CellIdentifier], solution: inout [Int], checkUnique: Bool) -> Int {
        if emptyCells.isEmpty { return 0 }
        
        var localEmptyCells = emptyCells
        let myCell = localEmptyCells.removeLast()
        var valueSet = Set([1,2,3,4,5,6,7,8,9])
        let cellsImpactedByMe = myCell.allImpactedSet
        var solutionCount = 0
        
        while let value = valueSet.randomElement(), ((checkUnique && solutionCount < 2) || solutionCount < 1) {
            valueSet.remove(value)
            if !cellsImpactedByMe.filter({ solution[$0.id] == value }).isEmpty {
                continue
            }
            
            solution[myCell.id] = value
            
            if localEmptyCells.isEmpty {
                return 1
            }
            
            solutionCount += solve(emptyCells: localEmptyCells,
                                   solution: &solution,
                                   checkUnique: checkUnique)
        }
        
        if checkUnique || solutionCount < 1 {
            solution[myCell.id] = 0
        }
        
        return solutionCount
    }
    
    /* Different implementations of problem solving / generating
    
    func generateV3() {
        generateSolutionV3()
        generateUniquePuzzleV3(difficulty)
    }
    
    func generateUniquePuzzleV3(_ difficulty: PuzzleDifficulty) {
        let givenCells = difficulty.cellsGiven.randomElement()!
        
        var given = solution
        var emptyCells = [CellIdentifier]()
        var filledCells = Set((0..<81).map { CellIdentifier(id: $0) })
        var cellOptions = [CellIdentifier: Set<Int>]()
        
        while filledCells.count > givenCells {
            let randCell = filledCells.randomElement()!
            var cellsAddedOption = Set<CellIdentifier>()
            
            given[randCell.id] = 0
            emptyCells.append(randCell)
            randCell.allImpactedSet.forEach {
                if cellOptions[$0, default: []].insert(solution[randCell.id]).inserted {
                    cellsAddedOption.insert($0)
                }
            }
            
            if solveV3(emptyCells: emptyCells, cellOptions: &cellOptions, solution: &given, checkUnique: true) != 1 {
                
                emptyCells.removeLast()
                given[randCell.id] = solution[randCell.id]
                cellsAddedOption.forEach {
                    cellOptions[$0, default:[]].remove(solution[randCell.id])
                }
            } else {
                filledCells.remove(randCell)
            }
        }
        
        self.given = given.map { $0 == 0 ? nil : $0 }
    }
    
    func generateSolutionV3() {
        var emptyCells = [CellIdentifier]()
        var cellOptions = [CellIdentifier: Set<Int>]()
        var solution = [Int]()
        
        for i in 0..<81 {
            let cell = CellIdentifier(id: i)
            emptyCells.append(cell)
            cellOptions[cell] = Set([1,2,3,4,5,6,7,8,9])
            solution.append(0)
        }
        
        solveV3(emptyCells: emptyCells,
                cellOptions: &cellOptions,
                solution: &solution,
                checkUnique: false)
        
        self.solution = solution
    }
    
    @discardableResult
    private func solveV3(emptyCells: [CellIdentifier],
                         cellOptions: inout [CellIdentifier: Set<Int>],
                         solution: inout [Int],
                         checkUnique: Bool) -> Int {
        
        // if there are no emptyCells, then this is a solution
        if emptyCells.isEmpty { return 1 }
        
        var localEmptyCells = emptyCells
        let myCell = localEmptyCells.removeLast()
        var valueSet = cellOptions[myCell] ?? []
        let cellsImpactedByMe = myCell.allImpactedSet
        var solutionCount = 0
        
        var cellsWhoseOptionsChanged: Set<CellIdentifier> = []
        
        while let value = valueSet.randomElement(), (solutionCount < 1 || (checkUnique && solutionCount < 2)) {
            
            cellsWhoseOptionsChanged = []
            valueSet.remove(value)
            
            var possibleSolution = true
            for cell in cellsImpactedByMe {
                if solution[cell.id] == value {
                    possibleSolution = false
                } else if cellOptions[cell]?.contains(value) ?? false {
                    cellsWhoseOptionsChanged.insert(cell)
                    cellOptions[cell]!.remove(value)
                    
                    possibleSolution = cell == myCell || !(solution[cell.id] == 0 && cellOptions[cell, default: []].isEmpty)
                }
                
                if !possibleSolution { break }
            }
            
            if !possibleSolution {
                cellsWhoseOptionsChanged.forEach {
                    cellOptions[$0, default: []].insert(value)
                }
                
                continue
            }
            
            solution[myCell.id] = value
            
            solutionCount += solveV3(emptyCells: localEmptyCells,
                                     cellOptions: &cellOptions,
                                     solution: &solution,
                                     checkUnique: checkUnique)
            
            cellsWhoseOptionsChanged.forEach {
                cellOptions[$0, default: []].insert(value)
            }
            
            if checkUnique || solutionCount < 1 {
                solution[myCell.id] = 0
            }
        }
        
        return solutionCount
    }
    
    private func generatePuzzleV1() {
        let cellOptions = (0..<81).reduce(into: [:]) { $0[CellIdentifier(id: $1)] = Set([1,2,3,4,5,6,7,8,9]) }
        var solution = [Int](repeating: -1, count: 81)
        
        solve(cellOptions: cellOptions,
              solution: &solution,
              countUnique: false)
        
        self.solution = solution
    }
    
    @discardableResult
    private func solveV1(cellOptions: [CellIdentifier: Set<Int>], solution: inout [Int], countUnique: Bool) -> Int {
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


