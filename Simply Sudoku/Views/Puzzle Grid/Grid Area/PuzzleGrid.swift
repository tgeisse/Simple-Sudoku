//
//  PuzzleGrid.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct PuzzleGrid: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<9, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<9, id: \.self) { col in
                        let squareId = CellIdentifier(row: row, col: col)
                        PuzzleGridCell(squareId: squareId)
                    }
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#if DEBUG
struct PuzzleGrid_Previews: PreviewProvider {
    static var puzzle: PuzzleViewModel {
        PuzzleViewModel(difficulty: .easy)
    }
    
    static var previews: some View {
        PuzzleGrid()
            .environmentObject(puzzle)
    }
}
#endif
