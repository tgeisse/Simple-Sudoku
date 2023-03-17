//
//  PuzzleDifficulties.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import Foundation

enum PuzzleDifficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var cellsGiven: ClosedRange<Int> {
        switch self {
        case .easy: return 46...52
        case .medium: return 36...45
        case .hard: return 31...35
        }
    }
}
