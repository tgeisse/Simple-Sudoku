//
//  PuzzleCellContents.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/9/23.
//

import SwiftUI

struct PuzzleCellContents: View {
    @EnvironmentObject var cellContents: CellContent
    
    var body: some View {
        ZStack {
            PuzzleCellHighlighting()
            
            if cellContents.guess != nil {
                Text(cellContents.guessText)
                    .lineLimit(1)
            } else if !cellContents.notes.isEmpty {
                Text(cellContents.noteText)
                    .minimumScaleFactor(0.1)
                    .lineLimit(2)
            }
        }
    }
}

struct PuzzleCellContents_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleCellContents()
    }
}
