//
//  PuzzleControlArea.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct PuzzleControlArea: View {
    var body: some View {
        VStack {
            PuzzleNumberControls()
                .padding([.leading, .trailing], 16)
            PuzzleEntryControls()
        }
    }
}

struct PuzzleControlArea_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleControlArea()
    }
}
