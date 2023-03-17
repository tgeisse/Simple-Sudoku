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
                    .font(.system(size: 50))
                    .monospaced()
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .padding(8)
            } else if !cellContents.notes.isEmpty {
                PuzzleCellContentNotes(notes: cellContents.notes)
            }
        }
        .contentShape(Rectangle())
    }
}

#if DEBUG
struct PuzzleCellContents_Previews: PreviewProvider {
    static var testContents: CellContent {
        let content = CellContent()
        content.notes.insert(4)
        return content
    }
    
    static var previews: some View {
        PuzzleCellContents()
            .environmentObject(testContents)
    }
}
#endif
