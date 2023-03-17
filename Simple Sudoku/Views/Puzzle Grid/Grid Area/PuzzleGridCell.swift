//
//  PuzzleGridSquare.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct PuzzleGridCell: View {
    var squareId: CellIdentifier
    @EnvironmentObject var puzzleViewModel: PuzzleViewModel
    
    var body: some View {
        ZStack {
            PuzzleCellContents()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .gesture(singleTap)
                .simultaneousGesture(doubleTap)
                .environmentObject(puzzleViewModel.cellContents[squareId.id])
            
            let borders = borderWeights
            GridCellBorder(topBorder: borders.top,
                             rightBorder: borders.right,
                             bottomBorder: borders.bottom,
                             leftBorder: borders.left)
        }
    }
    
    private var singleTap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                /* DebugUtil.print("top: ", borderWeights.top, ", bottom: ", borderWeights.bottom,
                 ", left: ", borderWeights.left, ", right: ", borderWeights.right, separator: "") */
                
                puzzleViewModel.registerCellTap(squareId)
            }
    }
    
    private var doubleTap: some Gesture {
        TapGesture(count: 2)
            .onEnded { _ in
                puzzleViewModel.toggleEntryMode()
            }
    }
    
    private var borderWeights: (top: GridCellBorder.BorderWeight,
                                right: GridCellBorder.BorderWeight,
                                bottom: GridCellBorder.BorderWeight,
                                left: GridCellBorder.BorderWeight) {
        
        (squareId.row == 0 ? .heavy : squareId.row % 3 == 0 ? .medium : .regular,
         squareId.col == 8 ? .heavy: (squareId.col + 1) % 3 == 0 ? .medium : .regular,
         squareId.row == 8 ? .heavy : (squareId.row + 1) % 3 == 0 ? .medium : .regular,
         squareId.col == 0 ? .heavy : squareId.col % 3 == 0 ? .medium : .regular)
    }
}

#if DEBUG
struct PuzzleGridCell_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleGridCell(squareId: CellIdentifier(id: 10))
    }
}
#endif
