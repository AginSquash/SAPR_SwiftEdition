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
    @State private var editRodValue: Rod? = nil
    
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
                
                /// free sapce for Edit and Delete buttons
                Spacer()
                    .frame(width: 100, height: 25, alignment: .center)
                
            }
            
           
            ScrollView(.vertical, showsIndicators: true) {
                    ForEach(Rods, id: \.id) { rod in
                        RodTableRowView(column_width: RodTableView.column_width, rod: rod, updateRod: self.updateRod)
                    }
            }
            
            Button("Add", action: {
                self.editRodValue = Rod.sample(with: Rods.count + 1)
            })
            Button("Random", action: {
                for _ in 0...5 {
                    self.Rods.append(Rod(id: self.Rods.count + 1, L: Float.random(in: 0...20), A: Float.random(in: 0...20), E: Float.random(in: 0...20), Sigma: Float.random(in: 0...20)))
                }
            })
            Spacer()
        }
        .padding()
        .sheet(item: $editRodValue, onDismiss: nil) { value in
            EditRodView(rod: value, updateRod: self.updateRod)
        }
        
    }
    
    func updateRod(with id: Int, L: Float, A: Float, E: Float, Sigma: Float) {
        if self.Rods.count < id {
            self.Rods.append(Rod(id: id, L: L, A: A, E: E, Sigma: Sigma))
        } else {
            self.Rods[id-1] = Rod(id: id, L: L, A: A, E: E, Sigma: Sigma)
        }
        print(Rods)
    }
}

struct RodTableView_Previews: PreviewProvider {
    static var previews: some View {
        RodTableView()
            .frame(width: 700, height: 400, alignment: .center)
    }
}
