//
//  LoadTableRowView.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 21.10.2021.
//

import SwiftUI

struct LoadTableRowView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let rowID: Int
    let load: LinearLoad
    
    var body: some View {
        ZStack {
            
            getBackColor(with: rowID, colorScheme: colorScheme)
                .frame(height: 25)
            
            HStack {
                Text("\(load.id)")
                    .frame(width: Loads.column_width)
                Text("\(load.q)")
                    .frame(width: Loads.column_width)
            }
        }
    }
}

struct LoadTableRowView_Previews: PreviewProvider {
    static var previews: some View {
        LoadTableRowView(rowID: 1, load: LinearLoad(id: 1, q: 10))
    }
}
