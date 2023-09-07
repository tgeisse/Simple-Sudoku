//
//  PuzzleViewModel.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import Foundation

class PuzzleViewModel: ObservableObject {
    @Published var puzzleReady = false
    @Published var cellContents: [CellContent] = (0..<81).map { _ in CellContent() }
    private(set) var generated = false
    
    let cellWarningTracker = CellWarningTracking()
    private var puzzle: Puzzle
    
    // MARK: - Controls for Cell Selection
    private var selectedGuessingCell: CellIdentifier? = nil
    private var selectedNotesCells: Set<CellIdentifier> = []
    private var entryMode = EntryMode.guessing
    
    enum EntryMode {
        case guessing
        case notes
    }
    
    #if DEBUG
    init() {
        puzzle = Puzzle(difficulty: .easy)
        
    }
    #endif
    
    init(difficulty: PuzzleDifficulty) {
        puzzle = Puzzle(difficulty: difficulty)
    }
    
    func generatePuzzle() {
        puzzle.generate()
        generated = true
    }
    
    func fillGivenCells() {
        for i in 0..<81 {
            cellContents[i].guess = puzzle.given[i]
            cellContents[i].given = puzzle.given[i] != nil
        }
    }
}

// MARK: - Puzzle Control Inputs
extension PuzzleViewModel {
    func numberPressed(_ number: Int) {
        switch entryMode {
        case .guessing: processNumberGuess(number)
        case .notes: processNewNote(number)
        }
    }
    
    private func processNumberGuess(_ num: Int) {
        guard let selectedCell = selectedGuessingCell else { return }
        
        if puzzle.given[selectedCell.id] == nil {
            cellContents[selectedCell.id].guess = num
        } else {
            cellWarningTracker.showGivenCellWarning = true
        }
        
        selectedCell.allImpactedSet
            .forEach { cellContents[$0.id].notes.remove(num) }
    }
    
    private func processNewNote(_ num: Int) {
        selectedNotesCells.forEach {
            if cellContents[$0.id].notes.insert(num).inserted == false {
                cellContents[$0.id].notes.remove(num)
            }
        }
    }
}

// MARK: - Cell Selection
extension PuzzleViewModel {
    func toggleEntryMode() {
        removeAllHighlighting()
        selectedNotesCells = []
        entryMode = entryMode == .notes ? .guessing : .notes
    }
    
    func registerCellTap(_ cellId: CellIdentifier) {
        switch entryMode {
        case .guessing: changeGuessingSelection(to: cellId)
        case .notes: toggleNotesCell(for: cellId)
        }
    }
    
    private func changeGuessingSelection(to cellId: CellIdentifier) {
        if cellId == selectedGuessingCell { return }
        
        let curSelGroup = selectedGuessingCell?.groupSet ?? []
        let curSelInline = selectedGuessingCell?.inlineSet ?? []
        
        let newSelGroup = cellId.groupSet
        let newSelInline = cellId.inlineSet
        
        // to clear highlighting
        curSelGroup.union(curSelInline).forEach { cellContents[$0.id].highlighting = .none }
        if selectedGuessingCell != nil { cellContents[selectedGuessingCell!.id].highlighting = .none }
        
        // new highlighting
        newSelGroup.forEach { cellContents[$0.id].highlighting = .group }
        newSelInline.forEach { cellContents[$0.id].highlighting = .inline }
        cellContents[cellId.id].highlighting = .selected
        
        selectedGuessingCell = cellId
    }
    
    private func toggleNotesCell(for cellId: CellIdentifier) {
        if selectedNotesCells.contains(cellId) {
            selectedNotesCells.remove(cellId)
            cellContents[cellId.id].highlighting = .none
        } else {
            selectedNotesCells.insert(cellId)
            cellContents[cellId.id].highlighting = .noteSelected
        }
    }
    
    private func removeAllHighlighting() {
        cellContents.forEach { $0.highlighting = .none }
    }
}
