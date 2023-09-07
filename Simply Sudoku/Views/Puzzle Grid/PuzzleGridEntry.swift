//
//  PuzzleGridEntry.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct PuzzleGridEntry: View {
    @StateObject private var puzzleViewModel: PuzzleViewModel
    
    init(puzzle: PuzzleViewModel) {
        _puzzleViewModel = StateObject(wrappedValue: puzzle)
    }
    
    var body: some View {
        VStack {
            PuzzleGridArea()
            PuzzleControlArea()
        }
        .environmentObject(puzzleViewModel)
        .environmentObject(puzzleViewModel.cellWarningTracker)
        .onAppear(perform: loadOrGeneratePuzzle)
    }
    
    private func loadOrGeneratePuzzle() {
        if !puzzleViewModel.generated {
            DispatchQueue.global(qos: .userInitiated).async {
                puzzleViewModel.generatePuzzle()
                
                DispatchQueue.main.async {
                    renderPuzzle()
                }
            }
        } else {
            renderPuzzle()
        }
    }
    
    private func renderPuzzle() {
        puzzleViewModel.fillGivenCells()
        puzzleViewModel.puzzleReady = true
    }
}

#if DEBUG
struct PuzzleGridEntry_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleGridEntry(puzzle: {
            let puzzle = PuzzleViewModel(difficulty: .easy)
            puzzle.generatePuzzle()
            return puzzle
        }())
    }
}
#endif
