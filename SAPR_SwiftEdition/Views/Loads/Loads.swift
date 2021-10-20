//
//  RodLoads.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 20.10.2021.
//

import SwiftUI

struct Loads: View {    
    static let column_width: CGFloat? = 125
    
    @ObservedObject var ConctructionDC: ConstructionDataController
    
    @State private var showAllLoadView: Bool = false
    @State private var showRodsSettedAlert: Bool = false
    
    var body: some View {
        HStack {
            
            LinearLoadsView
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .foregroundColor(Color.init(red: 141/255, green: 49/255, blue: 171/255))
                     
                VStack {
                    HStack {
                        Text("Номер стержня")
                            .frame(width: Loads.column_width)
                        Text("Распределенная нагрузка")
                            .frame(width: Loads.column_width)
                    }
                    .foregroundColor(.white)
                        Spacer()
                }
                .padding()
            }
        }
        .padding()
    }
    
    var LinearLoadsView: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .foregroundColor(Color.init(red: 0/255, green: 70/255, blue: 184/255))
                .shadow(radius: 15)
            VStack {
                HStack {
                    Text("Номер стержня")
                        .frame(width: Loads.column_width)
                    Text("Распределенная нагрузка")
                        .multilineTextAlignment(.center)
                        .frame(width: Loads.column_width)
                    Spacer()
                        .frame(width: 25, height: 25, alignment: .center)
                }
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 0) {
                        ForEach(ConctructionDC.Loads) { load in
                            HStack(spacing: 0) {
                                // change color!!!
                                LoadTableRowView(rowID: load.id, load: load)
                                Button(action: { deleteLinearLoad(with: load.id) }) {
                                    Image(systemName: "trash")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 15, alignment: .center)
                                }
                            }
                            .frame(height: 25)
                        }
                    }
                }
                Button("Add") {
                    if getIDRange().isEmpty {
                        showRodsSettedAlert = true
                        return
                    }
                    showAllLoadView = true
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .sheet(isPresented: $showAllLoadView) {
                AddLoadView(id_range: getIDRange(), ConctructionDC: ConctructionDC)
            }
            .alert(isPresented: $showRodsSettedAlert) {
                Alert(title: Text("Alert"), message: Text("Все силы уже установлены"), dismissButton: .cancel())
            }
        }
    }
    
    func getIDRange() -> [Int] {
        let alreadySettedRods = ConctructionDC.Loads
        
        var id_range = [Int]()
        for rod in ConctructionDC.Rods {
            if alreadySettedRods.contains(where: { $0.id == rod.id }) == false {
                id_range.append(rod.id)
            }
        }
        
        return id_range
    }
    
    func deleteLinearLoad(with id: Int) {
        withAnimation {
            ConctructionDC.Loads.removeAll(where: { $0.id == id })
        }
    }
}

struct RodLoads_Previews: PreviewProvider {
    static var previews: some View {
        Loads(ConctructionDC: ConstructionDataController.preview)
    }
}
