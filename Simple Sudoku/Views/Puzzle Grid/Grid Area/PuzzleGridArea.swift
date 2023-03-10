//
//  PuzzleGridArea.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct PuzzleGridArea: View {
    var body: some View {
        VStack {
            Spacer()
            PuzzleGrid()
            Spacer()
        }
        .padding()
    }
}

struct PuzzleGridArea_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleGridArea()
    }
}
