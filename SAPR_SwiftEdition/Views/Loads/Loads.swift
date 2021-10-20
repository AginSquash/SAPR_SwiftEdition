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
    
    var body: some View {
        HStack {
            ZStack {
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
                            ForEach(0..<ConctructionDC.Loads.count) { rowID in
                                LoadTableRowView(rowID: rowID, load: ConctructionDC.Loads[rowID])
                                    
                            }
                        }
                    }
                    Button("Add") {
                        showAllLoadView = true
                    }
                        Spacer()
                }
                .foregroundColor(.white)
                .padding()
                .sheet(isPresented: $showAllLoadView) {
                    AddLoadView(id_range: [1, 2, 3, 4])
                }
            }
            
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
}

struct RodLoads_Previews: PreviewProvider {
    static var previews: some View {
        Loads(ConctructionDC: ConstructionDataController.preview)
    }
}
