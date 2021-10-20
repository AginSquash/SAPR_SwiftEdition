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
                    }.foregroundColor(.white)
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
                        .frame(width: Loads.column_width)
                    
                }
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 0) {
                        ForEach(ConctructionDC.Loads) { load in
                            LoadTableRowView(rowID: load.id, load: load)
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
}

struct RodLoads_Previews: PreviewProvider {
    static var previews: some View {
        Loads(ConctructionDC: ConstructionDataController.preview)
    }
}
