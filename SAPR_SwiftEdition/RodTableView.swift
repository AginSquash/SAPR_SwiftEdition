//
//  RodTableView.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 14.10.2021.
//

import SwiftUI

struct RodTableView: View {
    static let column_width: CGFloat? = 100
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                    .frame(width: 40)
                Text("L стержня")
                    .frame(width: RodTableView.column_width)
                Text("Допускаемое напряжение Е")
                    .frame(width: RodTableView.column_width)
                Text("Площадь сечения A")
                    .frame(width: RodTableView.column_width)
                Text("Предел прочночти")
                    .frame(width: RodTableView.column_width)
            }
        }
    }
    
    
}

struct RodTableView_Previews: PreviewProvider {
    static var previews: some View {
        RodTableView()
            .frame(width: 700, height: 400, alignment: .center)
    }
}
