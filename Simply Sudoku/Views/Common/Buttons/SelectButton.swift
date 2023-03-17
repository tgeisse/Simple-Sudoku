//
//  ToggleButton.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct SelectButton: View {
    var label: String
    var action: () -> ()
    var isSelected: Bool
    
    init(_ label: String, isSelected: Bool = false, action: @escaping () -> Void = {}) {
        self.label = label
        self.isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ButtonLabel(label: label, showBackground: isSelected)
        }
        .buttonStyle(.plain)
        .animation(.easeOut(duration: 0.35), value: isSelected)
    }
}

#if DEBUG
struct SelectButton_Previews: PreviewProvider {
    @State static private var selValue = false
    
    static var previews: some View {
        SelectButton("Hello World", isSelected: selValue) { selValue.toggle() }
    }
}
#endif
