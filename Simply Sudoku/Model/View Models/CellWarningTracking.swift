//
//  GivenCellWarning.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/17/23.
//

import Foundation

class CellWarningTracking: ObservableObject {
    @Published var showGivenCellWarning = false {
        didSet {
            if showGivenCellWarning == false { return }
            
            workItem?.cancel()
            workItem = DispatchWorkItem { [weak self] in
                self?.showGivenCellWarning = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: workItem!)
        }
    }
    
    private var workItem: DispatchWorkItem? = nil
}
