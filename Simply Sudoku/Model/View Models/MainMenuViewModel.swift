//
//  MainMenuViewModel.swift
//  Simply Sudoku
//
//  Created by Taylor Geisse on 9/6/23.
//

import Foundation

final class MainMenuViewModel: ObservableObject {
    @Published var generatedPuzzles: [PuzzleDifficulty: PuzzleViewModel] = [:]
    @Published var selectedDifficulty: PuzzleDifficulty?
    var selectedPuzzle: PuzzleViewModel? {
        guard let selectedDifficulty = selectedDifficulty else { return nil }
        return generatedPuzzles[selectedDifficulty]
    }
    
    init() {
        PuzzleDifficulty.allCases.forEach { difficulty in
            DispatchQueue.global().async { [weak self] in
                self?.generatePuzzle(difficulty)
            }
        }
    }
    
    private func generatePuzzle(_ difficulty: PuzzleDifficulty) {
        let puzzle = PuzzleViewModel(difficulty: difficulty)
        puzzle.generatePuzzle()
        DispatchQueue.main.async { [weak self] in
            self?.generatedPuzzles[difficulty] = puzzle
        }
    }
}
