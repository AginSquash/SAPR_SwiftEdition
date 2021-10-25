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
    let id: String
    let value: String
    
    var body: some View {
        ZStack {
            
            getBackColor(with: rowID, colorScheme: colorScheme)
                .frame(height: 25)
            
            HStack {
                Text(id)
                    .frame(width: Loads.column_width)
                Text(value)
                    .frame(width: Loads.column_width)
            }
        }
    }
    
    init(rowID: Int, linearLoad: LinearLoad? = nil, nodeLoad: Node? = nil) {
        self.rowID = rowID
        
        if (linearLoad != nil) && (nodeLoad != nil) {
            fatalError("one of value must be nil!")
        }
        
        if let linear = linearLoad {
            id = String(linear.id)
            value = String(linear.q)
            return
        }
        
        if let node = nodeLoad {
            id = String(node.id)
            value = String(node.F)
            return
        }
        
        fatalError("one of value must be setted!")
    }
}

struct LoadTableRowView_Previews: PreviewProvider {
    static var previews: some View {
        LoadTableRowView(rowID: 1, linearLoad: LinearLoad(id: 1, q: 10))
    }
}
