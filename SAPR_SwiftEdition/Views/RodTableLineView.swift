//
//  RodTableLineView.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 14.10.2021.
//

import SwiftUI
import Combine

struct RodTableLineView: View {
    let column_width: CGFloat?
    let id: Int
    
    @State private var L: String = ""
    var body: some View {
        HStack {
            TextField("", text: $L, onEditingChanged: { _ in
                let filtered = L.filter { "0123456789".contains($0) }
                if filtered != L {
                    self.L = filtered
                }})
                .frame(width: column_width)
            TextField("", text: $L)
                
                .frame(width: column_width)
        }
    }
}

struct RodTableLineView_Previews: PreviewProvider {
    static var previews: some View {
        RodTableLineView(column_width: 100, id: 1)
            .frame(width: 600, height: 200)
    }
}
