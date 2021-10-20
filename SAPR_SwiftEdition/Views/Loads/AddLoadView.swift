//
//  AddLoadView.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 21.10.2021.
//

import SwiftUI

struct AddLoadView: View {
    static let column_width: CGFloat? = 125
    let id_range: [Int]
    
    @State private var selectedID: Int = 0
    @State private var enteredLoad: String = ""
    var body: some View {
        VStack {
            HStack {
                Text("Номер стержня")
                    .frame(width: AddLoadView.column_width)
                Text("Распределенная нагрузка")
                    .frame(width: AddLoadView.column_width)
            }
            HStack {
                Picker(selection: $selectedID, label: Text("")) {
                    ForEach(0..<id_range.count) { i in
                        Text("\(id_range[i])").tag(i)
                    }
                }
                .frame(width: AddLoadView.column_width)
                
                TextField("", text: $enteredLoad)
                    .frame(width: AddLoadView.column_width)
            }
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

struct AddLoadView_Previews: PreviewProvider {
    static var previews: some View {
        AddLoadView(id_range: [1, 2, 3])
    }
}
