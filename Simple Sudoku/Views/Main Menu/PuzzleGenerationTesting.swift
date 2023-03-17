//
//  PuzzleGenerationTesting.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/13/23.
//


/*
import SwiftUI
 
struct PuzzleGenerationTesting: View {
    @State private var v1Average: Double = 0
    @State private var v1Runs = 0
    @State private var v3Average: Double = 0
    @State private var v3Runs = 0
    
    @State private var running = false
    
    private let iterations = 100
    
    var body: some View {
        VStack {
            Text("V1 Average: \(v1Average)")
            Text("V3 Average: \(v3Average)")
            
            SelectButton(running ? "Running (\(v3Runs) / \(iterations))" : "Run for \(iterations) runs") {
                runFor10()
            }
            .disabled(running)
            
            SelectButton("Clear") {
                v1Average = 0
                v1Runs = 0
                v3Average = 0
                v3Runs = 0
            }
            .disabled(running)
        }
    }
    
    private func runFor10() {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                running = true
            }
            
            let diff = PuzzleDifficulty.medium
            let puzzle = Puzzle(difficulty: diff)
            
            for _ in 0..<iterations {
                DebugUtil.print("V1 run start")
                let v1Start = Date()
                puzzle.generateV1()
                let v1End = Date()
                
                DispatchQueue.main.async {
                    v1Runs += 1
                    v1Average += (v1End.timeIntervalSince(v1Start) - v1Average) / Double(v1Runs)
                }
                
                DebugUtil.print("V3 run start")
                let v3Start = Date()
                puzzle.generateV3()
                let v3End = Date()
                
                DispatchQueue.main.async {
                    v3Runs += 1
                    v3Average += (v3End.timeIntervalSince(v3Start) - v3Average) / Double(v3Runs)
                }
            }
            
            DispatchQueue.main.async {
                running = false
            }
        }
    }
}

struct PuzzleGenerationTesting_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleGenerationTesting()
    }
}
*/
