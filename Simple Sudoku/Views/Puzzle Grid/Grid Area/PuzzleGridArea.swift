//
//  PuzzleGridArea.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct PuzzleGridArea: View {
    @EnvironmentObject private var puzzleViewModel: PuzzleViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                if !puzzleViewModel.puzzleReady {
                    ProgressView()
                        .tint(.blue)
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.gray)
                        )
                        .scaleEffect(4)
                }
                
                PuzzleGrid()
            }
            
            Spacer()
        }
        .padding()
    }
}

#if DEBUG
struct PuzzleGridArea_Previews: PreviewProvider {
    static let pvm = PuzzleViewModel()
    
    static var previews: some View {
        PuzzleGridArea()
            .environmentObject(pvm)
    }
}
#endif
