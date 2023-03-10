//
//  PuzzleViewModel.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import Foundation

class PuzzleViewModel: ObservableObject {
    @Published var cellContents: [CellContent] = []
    private var puzzle: Puzzle
    
    // MARK: - Controls for Cell Selection
    private var selectedGuessingCell: CellIdentifier? = nil
    private var selectedNotesCells: Set<CellIdentifier> = []
    private var entryMode = EntryMode.guessing
    
    enum EntryMode {
        case guessing
        case notes
    }
    
    
    init(difficulty: PuzzleDifficulty) {
        puzzle = Puzzle(difficulty: difficulty)
        
        for i in 0..<81 {
            let cellContent = CellContent()
            cellContent.guess = puzzle.given[i]
            cellContents.append(cellContent)
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
        cellContents[selectedCell.id].guess = num
        
        selectedCell.getCellGroupSet()
            .union(selectedCell.getCellInlineSet())
            .forEach { cellContents[$0.id].notes[num - 1] = false }
    }
    
    private func processNewNote(_ num: Int) {
        selectedNotesCells.forEach { cellContents[$0.id].notes[num - 1].toggle() }
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
        
        let curSelGroup = selectedGuessingCell?.getCellGroupSet() ?? []
        let curSelInline = selectedGuessingCell?.getCellInlineSet() ?? []
        
        let newSelGroup = cellId.getCellGroupSet()
        let newSelInline = cellId.getCellInlineSet()
        
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
