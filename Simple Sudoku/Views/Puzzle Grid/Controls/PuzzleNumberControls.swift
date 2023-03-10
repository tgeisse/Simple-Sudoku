//
//  PuzzleNumberControls.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct PuzzleNumberControls: View {
    @EnvironmentObject private var puzzleViewModel: PuzzleViewModel
    
    var body: some View {
        HStack {
            ForEach(1...9, id: \.self) { num in
                Button {
                    DebugUtil.print("Pressed the \(num) button")
                    puzzleViewModel.numberPressed(num)
                } label: {
                    ButtonLabel(label: "\(num)", showBackground: true)
                }
                .buttonStyle(.plain)
                .aspectRatio(1, contentMode: .fit)
            }
        }
    }
}

struct PuzzleNumberControls_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleNumberControls()
    }
}
