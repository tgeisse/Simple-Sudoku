//
//  PuzzleGridEntry.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct PuzzleGridEntry: View {
    @StateObject private var puzzleViewModel: PuzzleViewModel
    
    init(difficulty: PuzzleDifficulty) {
        _puzzleViewModel = StateObject(wrappedValue: PuzzleViewModel(difficulty: difficulty))
    }
    
    var body: some View {
        VStack {
            PuzzleGridArea()
            PuzzleControlArea()
        }
        .environmentObject(puzzleViewModel)
    }
}

struct PuzzleGridEntry_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleGridEntry(difficulty: .medium)
    }
}
