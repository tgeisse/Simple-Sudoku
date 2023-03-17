//
//  ToggleButton.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct NavigationButton<Content: View>: View {
    var label: String
    var isEnabled: Bool
    var destination: () -> Content
    
    init(_ label: String, enabled: Bool = false, destination: @escaping () -> Content) {
        self.label = label
        self.isEnabled = enabled
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink {
            destination()
        } label: {
            ButtonLabel(label: label, showBackground: true)
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .animation(.easeOut(duration: 0.35), value: isEnabled)
    }
}

#if DEBUG
struct NavigationButton_Previews: PreviewProvider {
    @State static private var selValue = false
    
    static var previews: some View {
        SelectButton("Hello World", isSelected: selValue) { selValue.toggle() }
    }
}
#endif
