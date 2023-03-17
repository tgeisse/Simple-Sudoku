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
            GivenCellWarning()
                .padding(.bottom, 10)
            
            PuzzleNumberControls()
                .padding([.leading, .trailing], 16)
            

            PuzzleEntryControls()
        }
    }
}

#if DEBUG
struct PuzzleControlArea_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleControlArea()
    }
}
#endif
