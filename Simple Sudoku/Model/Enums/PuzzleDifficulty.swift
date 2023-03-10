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
        case .easy: return (40...45)
        case .medium: return (33...37)
        case .hard: return (27...32)
        }
    }
}
