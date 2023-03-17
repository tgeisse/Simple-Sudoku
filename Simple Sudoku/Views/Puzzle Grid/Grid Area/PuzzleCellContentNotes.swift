//
//  PuzzleCellContentNotes.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/17/23.
//

import SwiftUI

struct PuzzleCellContentNotes: View {
    let notes: Set<Int>
    
    private var notesStrings: [String] {
        [notesString(forRange: 1...3),
         notesString(forRange: 4...6),
         notesString(forRange: 7...9)]
    }
    
    private func notesString(forRange range: ClosedRange<Int>) -> String {
        range.reduce("") { $0 + (notes.contains($1) ? "\($1)" : " ") }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            let notesStrings = self.notesStrings
            ForEach(0..<notesStrings.count, id: \.self) { noteRow in
                Text(notesStrings[noteRow])
            }
        }
        .foregroundColor(.green)
        .monospaced()
        .minimumScaleFactor(0.1)
        .padding(3)
    }
}

#if DEBUG
struct PuzzleCellContentNotes_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleCellContentNotes(notes: [4,8,1])
    }
}
#endif
