//
//  ButtonLabel.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct ButtonLabel: View {
    var label: String
    var showBackground: Bool
    
    var body: some View {
        Text(label)
            .padding([.top, .bottom], 8)
            .padding([.leading, .trailing], 10)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangleFill(border: .black,
                                     background: showBackground ? .blue.opacity(0.8) : .white,
                                     cornerRadius: 8)
            )
    }
}

#if DEBUG
struct ButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLabel(label: "Hello World", showBackground: true)
    }
}
#endif
