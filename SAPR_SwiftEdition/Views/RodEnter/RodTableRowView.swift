//
//  RodTableLineView.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 14.10.2021.
//

import SwiftUI
import Combine

struct RodTableRowView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let column_width: CGFloat?
    let rod: Rod
        
    @State private var L: String = ""
    @State private var A: String = ""
    @State private var E: String = ""
    @State private var Sigma: String = ""
    
    var body: some View {
        HStack {
            Text("\(rod.id)")
                .frame(width: column_width)
            Group {
                Text("\(rod.L)")
                    .frame(width: column_width)
                Text("\(rod.E)")
                    .frame(width: column_width)
                Text("\(rod.A)")
                    .frame(width: column_width)
                Text("\(rod.Sigma)")
                    .frame(width: column_width)
            }
            .multilineTextAlignment(.trailing)
            
        }
    }
}

struct RodTableLineView_Previews: PreviewProvider {
    static var previews: some View {
        RodTableRowView(column_width: 100, rod: Rod(id: 1, L: 0, A: 0, E: 0, Sigma: 0))
            .frame(width: 600, height: 200)
    }
}
