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
    
    @Published var notes: Set<Int> = []
    
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
            case .noteSelected: return .green.opacity(0.7)
            }
        }
    }
    
    @Published var highlighting: Highlight = .none
    
    @Published var given: Bool = false
}
