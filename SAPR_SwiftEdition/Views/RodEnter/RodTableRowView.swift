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
    
    var updateRod: ((_ id: Int, _ L: Float, _ A: Float, _ E: Float, _ Sigma: Float) -> Void)?
    
    @State private var L: String = ""
    @State private var A: String = ""
    @State private var E: String = ""
    @State private var Sigma: String = ""
    
    var body: some View {
        ZStack {
            
            getBackColor(with: rod.id, colorScheme: colorScheme)
                .frame(height: 25)
            
            HStack {
                Text("\(rod.id)")
                    .frame(width: column_width)
                Group {
                    Text("\(rod.L)")
                        .frame(width: column_width)
                    Text("\(rod.A)")
                        .frame(width: column_width)
                    Text("\(rod.E)")
                        .frame(width: column_width)
                    Text("\(rod.Sigma)")
                        .frame(width: column_width)
                }
                .multilineTextAlignment(.trailing)
                
            }
        }
    }
    
    func changed() {
        let L = Float(self.L) ?? 0
        let A = Float(self.A) ?? 0
        let E = Float(self.E) ?? 0
        let Sigma = Float(self.Sigma) ?? 0
        
        guard let updateRod = updateRod else {
            return
        }

        updateRod(rod.id, L, A, E, Sigma)
    }
    
    func NumberOnly(text: Binding<String>) {
        let text_wrapped = text.wrappedValue
        let filtered = text_wrapped.filter { ".0123456789".contains($0) }
        if filtered != text_wrapped {
            text.wrappedValue = filtered
            changed()
            // Add error alert!
        }
    }
}

struct RodTableLineView_Previews: PreviewProvider {
    static var previews: some View {
        RodTableRowView(column_width: 100, rod: Rod(id: 1, L: 0, A: 0, E: 0, Sigma: 0), updateRod: nil)
            .frame(width: 600, height: 200)
    }
}