//
//  LoadTableRowView.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 21.10.2021.
//

import SwiftUI

struct LoadTableRowView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let column_width: CGFloat?
    let rowID: Int
    let load: LinearLoad
    
    var body: some View {
        ZStack {
            
            getBackColor(with: rowID, colorScheme: colorScheme)
                .frame(height: 25)
            
            HStack {
                Text("\(load.id)")
                    .frame(width: column_width)
                Text("\(load.q)")
                    .frame(width: column_width)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

struct LoadTableRowView_Previews: PreviewProvider {
    static var previews: some View {
        LoadTableRowView(column_width: 125, rowID: 1, load: LinearLoad(id: 1, q: 10))
    }
}
