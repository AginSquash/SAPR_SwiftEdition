//
//  RodTableView.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 14.10.2021.
//

import SwiftUI

struct RodTableView: View {
    static let column_width: CGFloat? = 100
    
    @ObservedObject var ConctructionDC: ConstructionDataController
    
    @State private var editRodValue: Rod? = nil
    @State private var rodOnDelete: Rod? = nil
    
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
                ForEach(ConctructionDC.Rods, id: \.id) { rod in
                    HStack {
                        RodTableRowView(column_width: RodTableView.column_width, rod: rod, updateRod: self.updateRod)
                        
                        Button(action: { editRod(rod) } ) {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 15, alignment: .center)
                        }
                        Button(action: { self.rodOnDelete = rod } ) {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 15, alignment: .center)
                            }
                        }
                        .padding(.bottom, -5)
                        .transition(.opacity)
                    }
            }
            
            Button("Add", action: {
                self.editRodValue = Rod.sample(with: ConctructionDC.Rods.count + 1)
            })
            Button("Random", action: {
                for _ in 0...5 {
                    self.ConctructionDC.Rods.append(Rod(id: self.ConctructionDC.Rods.count + 1, L: Float.random(in: 0...20), A: Float.random(in: 0...20), E: Float.random(in: 0...20), Sigma: Float.random(in: 0...20)))
                }
            })
            Spacer()
        }
        .padding()
        .sheet(item: $editRodValue, onDismiss: nil) { value in
            EditRodView(rod: value, updateRod: self.updateRod)
        }
        .alert(item: $rodOnDelete) { rod in
            Alert(title: Text("Удаление!"), message: Text("Вы действительно хотите удалить стержень №\(rod.id)?"), primaryButton: .destructive(Text("Да"), action: { deleteRod(rod) }), secondaryButton: .cancel())
        }
        
    }
    
    func editRod(_ rod: Rod) {
        editRodValue = rod
    }
    
    func deleteRod(_ rod: Rod) {
        withAnimation(.easeIn(duration: 0.4)) {
            _ = ConctructionDC.Rods.remove(at: rod.id - 1)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for i in 0..<ConctructionDC.Rods.count {
                withAnimation(.easeIn(duration: 0.4)) {
                    ConctructionDC.Rods[i].id = i + 1
                }
            }
        }
    }
    
    func updateRod(with id: Int, L: Float, A: Float, E: Float, Sigma: Float) {
        if self.ConctructionDC.Rods.count < id {
            self.ConctructionDC.Rods.append(Rod(id: id, L: L, A: A, E: E, Sigma: Sigma))
        } else {
            self.ConctructionDC.Rods[id-1] = Rod(id: id, L: L, A: A, E: E, Sigma: Sigma)
        }
        print(ConctructionDC.Rods)
    }
}


struct RodTableView_Previews: PreviewProvider {
    static var previews: some View {
        RodTableView(ConctructionDC: ConstructionDataController.preview)
            .frame(width: 700, height: 400, alignment: .center)
    }
}
