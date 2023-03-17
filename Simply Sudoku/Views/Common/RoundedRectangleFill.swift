//
//  RoundedRectangleAnimatedFill.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct RoundedRectangleFill: View {
    var border: Color
    var background: Color
    var cornerRadius: CGFloat = 5
    var borderWidth: CGFloat = 2
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(border, lineWidth: borderWidth)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                .fill(background)
            )
    }
}

#if DEBUG
struct RoundedRectangleFill_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleFill(border: .black, background: .black)
    }
}
#endif
