//
//  GridSquareBorder.swift
//  Simple Sudoku
//
//  Created by Taylor Geisse on 3/7/23.
//

import SwiftUI

struct GridCellBorder: View {
    enum BorderWeight {
        case none
        case regular
        case medium
        case heavy
        
        var strokeWidth: CGFloat {
            let baseWidth: CGFloat = 0.35
            
            switch self {
            case.none: return 0
            case .regular: return baseWidth
            case .medium: return baseWidth * 3
            case .heavy: return baseWidth * 8
            }
        }
    }
    
    var topBorder: BorderWeight
    var rightBorder: BorderWeight
    var bottomBorder: BorderWeight
    var leftBorder: BorderWeight
    
    var body: some View {
        GeometryReader { proxy in
            Rectangle()
                .fill(.black)
                .offset(x: 0, y: 0)
                .frame(width: proxy.size.width, height: topBorder.strokeWidth)
            
            Rectangle()
                .fill(.black)
                .offset(x: proxy.size.width - rightBorder.strokeWidth, y: 0)
                .frame(width: rightBorder.strokeWidth, height: proxy.size.height)
            
            Rectangle()
                .fill(.black)
                .offset(x: 0, y: proxy.size.height - bottomBorder.strokeWidth)
                .frame(width: proxy.size.width, height: bottomBorder.strokeWidth)
            
            Rectangle()
                .fill(.black)
                .offset(x: 0, y: 0)
                .frame(width: leftBorder.strokeWidth, height: proxy.size.height)
        }
    }
}

struct GridCellBorder_Previews: PreviewProvider {
    static var previews: some View {
        GridCellBorder(topBorder: .heavy, rightBorder: .regular, bottomBorder: .heavy, leftBorder: .heavy)
            .frame(width:300, height: 300)
    }
}
