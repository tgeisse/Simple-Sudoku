//
//  CellContents.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/9/23.
//

import Foundation
import SwiftUI

class CellContent: ObservableObject {
    @Published var guess: Int? = nil
    var guessText: String { guess == nil ? " " : "\(guess!)" }
    
    @Published var notes: [Bool] = .init(repeating: false, count: 9)
    var noteText: String { notes.enumerated().reduce("") { $0 + ($1.1 ? "\($1.0 + 1)" : " ") }}
    
    
    enum Highlight {
        case none
        case selected
        case group
        case inline
        case noteSelected
        
        var color: Color {
            switch self {
            case .none: return .clear
            case .selected: return .orange.opacity(0.8)
            case .group: return .orange.opacity(0.1)
            case .inline: return .orange.opacity(0.3)
            case .noteSelected: return .green.opacity(0.8)
            }
        }
    }
    
    @Published var highlighting: Highlight = .none
}
