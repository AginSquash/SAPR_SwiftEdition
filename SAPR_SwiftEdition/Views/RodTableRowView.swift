//
//  RodTableLineView.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 14.10.2021.
//

import SwiftUI
import Combine

struct RodTableRowView: View {
    let column_width: CGFloat?
    @Binding var rod: Rod
    
    
    @State private var L: String = ""
    @State private var A: String = ""
    @State private var E: String = ""
    @State private var Sigma: String = ""
    
    var body: some View {
        HStack {
            Text("\(rod.id)")
                .frame(width: column_width)
            Group {
                TextField("", text: $L, onEditingChanged:
                            { _ in NumberOnly(text: $L) })
                    .frame(width: column_width)
                TextField("", text: $A, onEditingChanged:
                            { _ in NumberOnly(text: $A) })
                    .frame(width: column_width)
                TextField("", text: $E, onEditingChanged:
                            { _ in NumberOnly(text: $E) })
                    .frame(width: column_width)
                TextField("", text: $Sigma, onEditingChanged:
                            { _ in NumberOnly(text: $Sigma) })
                    .frame(width: column_width)
            }
            .multilineTextAlignment(.trailing)
        }
    }
    
    func NumberOnly(text: Binding<String>) {
        let text_wrapped = text.wrappedValue
        let filtered = text_wrapped.filter { ".0123456789".contains($0) }
        if filtered != text_wrapped {
            text.wrappedValue = filtered
            // Add error alert!
        }
    }
}

struct RodTableLineView_Previews: PreviewProvider {
    static var previews: some View {
        RodTableRowView(column_width: 100, rod: .constant(Rod(id: 1, L: 0, A: 0, E: 0, Sigma: 0)))
            .frame(width: 600, height: 200)
    }
}
