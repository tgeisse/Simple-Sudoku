//
//  PuzzleCellHighlighting.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/9/23.
//

import SwiftUI

struct PuzzleCellHighlighting: View {
    @EnvironmentObject var cellContents: CellContent
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(cellContents.highlighting.color)
                .animation(.easeOut(duration: 0.25), value: cellContents.highlighting)
        }
    }
}

struct PuzzleCellHighlighting_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleCellHighlighting()
    }
}
