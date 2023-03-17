//
//  Logo.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        HStack {
            Text("S")
                .font(.system(size: 300, weight: .medium))
                .minimumScaleFactor(0.01)
            
            VStack(alignment: .leading) {
                Text("imply")
                Text("udoku")
            }
            .font(.system(size: 200, weight: .medium))
            .minimumScaleFactor(0.01)
        }
    }
}

#if DEBUG
struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
#endif
