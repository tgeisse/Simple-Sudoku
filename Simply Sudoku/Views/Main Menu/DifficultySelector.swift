//
//  DifficultySelector.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct DifficultySelector: View {
    @Binding var difficulty: PuzzleDifficulty?
    @State private var buttonWidth: CGFloat = 20
    @EnvironmentObject private var mainMenuVM: MainMenuViewModel
    
    init(difficulty: Binding<PuzzleDifficulty?> = Binding.constant(nil)) {
        self._difficulty = difficulty
    }
    
    var body: some View {
        HStack {
            ForEach(PuzzleDifficulty.allCases, id: \.rawValue) { diff in
                SelectButton(diff.rawValue, isSelected: diff == difficulty) {
                    difficulty = diff
                }
                .disabled(mainMenuVM.generatedPuzzles[diff] == nil)
            }
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

#if DEBUG
struct DifficultySelector_Previews: PreviewProvider {
    static var previews: some View {
        DifficultySelector(difficulty: .constant(.medium))
    }
}
#endif
