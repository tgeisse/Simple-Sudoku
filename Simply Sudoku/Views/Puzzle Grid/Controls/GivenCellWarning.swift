//
//  GivenCellWarning.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/17/23.
//

import SwiftUI

struct GivenCellWarning: View {
    @EnvironmentObject private var cellWarningTracker: CellWarningTracking
    @State private var opacity = 0.0
    @State private var hideWork: DispatchWorkItem?
    
    var body: some View {
        Text("This was a given cell and cannot be changed")
            .font(.system(size: 12))
            .foregroundColor(.white)
            .padding([.leading, .trailing], 10)
            .padding([.top, .bottom], 6)
            .background(
                RoundedRectangleFill(border: .gray,
                                     background: .blue,
                                     borderWidth: 1.0)
            )
            .opacity(opacity)
            .onChange(of: cellWarningTracker.showGivenCellWarning) {
                if $0 {
                    withAnimation(.easeIn(duration: 0.15)) { opacity = 1 }
                } else {
                    withAnimation(.easeOut(duration: 0.75)) { opacity = 0 }
                }
                    
            }
    }
}

#if DEBUG
struct GivenCellWarning_Previews: PreviewProvider {
    static let pvm = PuzzleViewModel()
    
    static var previews: some View {
        GivenCellWarning()
            .environmentObject(pvm)
    }
}
#endif
