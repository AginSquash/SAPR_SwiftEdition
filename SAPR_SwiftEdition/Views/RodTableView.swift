//
//  RodTableView.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 14.10.2021.
//

import SwiftUI

struct RodTableView: View {
    static let column_width: CGFloat? = 100
    
    @State private var Rods: [Rod] = []
    var body: some View {
        VStack {
            HStack {
                Text("Номер стержня")
                    .frame(width: RodTableView.column_width)
                Text("L стержня")
                    .frame(width: RodTableView.column_width)
                Text("Допускаемое напряжение Е")
                    .frame(width: RodTableView.column_width)
                Text("Площадь сечения A")
                    .frame(width: RodTableView.column_width)
                Text("Предел прочночти")
                    .frame(width: RodTableView.column_width)
            }
            
            ForEach(Rods, id: \.id) { rod in
                RodTableRowView(column_width: RodTableView.column_width, rod: rod, updateRod: self.updateRod)
            }
            Button("Add", action: {
                self.Rods.append(Rod(id: Rods.count+1, L: 0, A: 0, E: 0, Sigma: 0))
                print(Rods)
            })
            Spacer()
        }
        .padding()
    }
    
    func updateRod(with id: Int, L: Float, A: Float, E: Float, Sigma: Float) {
        self.Rods[id-1] = Rod(id: id, L: L, A: A, E: E, Sigma: Sigma)
    }
}

struct RodTableView_Previews: PreviewProvider {
    static var previews: some View {
        RodTableView()
            .frame(width: 700, height: 400, alignment: .center)
    }
}
