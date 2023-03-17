//
//  PuzzleEntryControls.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct PuzzleEntryControls: View {
    var body: some View {
        HStack {
           // Text("Future controls, like undo / redo, random guess, etc.")
            Spacer()
                .frame(height: 70)
        }
    }
}

#if DEBUG
struct PuzzleEntryControls_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleEntryControls()
    }
}
#endif
