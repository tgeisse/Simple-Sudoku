//
//  MainMenu.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct MainMenu: View {
    @State private var difficulty: PuzzleDifficulty? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Logo()
                
                Spacer(minLength: 10)
                
                VStack(spacing: 15) {
                    DifficultySelector(difficulty: $difficulty)
                    
                    NavigationButton("Play!", enabled: difficulty != nil) {
                        PuzzleGridEntry(difficulty: difficulty ?? .medium)
                    }
                }
                .fixedSize(horizontal: true, vertical: false)
                
                Spacer()
            }
            .padding(20)
            .frame(width: 400)
            .navigationTitle("Main Menu")
            .toolbar(.hidden, for: .automatic)
        }
    }
}

#if DEBUG
struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
#endif
