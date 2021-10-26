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
    
    @State private var showAddLinearLoadView: Bool = false
    @State private var showRodsSettedAlert: Bool = false
    
    @State private var showAddNodeLoadView: Bool = false
    @State private var showNodesSettedAlert: Bool = false
    
    
    var body: some View {
        HStack {
            
            LinearLoadsView
            
            Spacer()
            
            NodesLoads
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
                                LoadTableRowView(rowID: load.id, linearLoad: load)
                                Button(action: { deleteLinearLoad(with: load.id) }) {
                                    Image(systemName: "trash")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.primary)
                                        .frame(width: 25, height: 15, alignment: .center)
                                }
                            }
                            .frame(height: 25)
                        }
                    }
                }
                Button("Add") {
                    if getLoadsIDRange().isEmpty {
                        showRodsSettedAlert = true
                        return
                    }
                    showAddLinearLoadView = true
                }.foregroundColor(.primary)
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .sheet(isPresented: $showAddLinearLoadView) {
                AddLoadView(id_range: getLoadsIDRange(), isLinearLoad: true, ConctructionDC: ConctructionDC)
            }
            .alert(isPresented: $showRodsSettedAlert) {
                Alert(title: Text("Alert"), message: Text("Все нагрузки уже заданы"), dismissButton: .cancel())
            }
        }
    }
    
    
    var NodesLoads: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .foregroundColor(Color.init(red: 141/255, green: 49/255, blue: 171/255))
                .shadow(radius: 15)
            VStack {
                HStack {
                    Text("Номер узла")
                        .frame(width: Loads.column_width)
                        .onTapGesture {
                            print("Rods: \(ConctructionDC.Rods)")
                            print("LinearLoads: \(ConctructionDC.Loads)")
                            print("Nodes: \(ConctructionDC.Nodes)")
                        }
                    Text("Сосредоточенная нагрузка")
                        .multilineTextAlignment(.center)
                        .frame(width: Loads.column_width)
                    Spacer()
                        .frame(width: 25, height: 25, alignment: .center)
                }
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 0) {
                        ForEach(ConctructionDC.Nodes) { node in
                            HStack(spacing: 0) {
                                // change color!!!
                                LoadTableRowView(rowID: node.id, nodeLoad: node)
                                Button(action: { deleteNodeLoad(with: node.id) }) {
                                    Image(systemName: "trash")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.primary)
                                        .frame(width: 25, height: 15, alignment: .center)
                                }
                            }
                            .frame(height: 25)
                        }
                           
                    }
                }
                Button("Add") {
                    if getNodesIDRange().isEmpty {
                        showNodesSettedAlert = true
                        return
                    }
                    
                    showAddNodeLoadView = true
                }.foregroundColor(.primary)
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .sheet(isPresented: $showAddNodeLoadView) {
                AddLoadView(id_range: getNodesIDRange(), isLinearLoad: false, ConctructionDC: ConctructionDC)
            }
            .alert(isPresented: $showNodesSettedAlert) {
                Alert(title: Text("Alert"), message: Text("Все нагрузки уже заданы"), dismissButton: .cancel())
             }
        }

    }
    
    func getLoadsIDRange() -> [Int] {
        let alreadySettedRods = ConctructionDC.Loads
        
        var id_range = [Int]()
        for rod in ConctructionDC.Rods {
            if alreadySettedRods.contains(where: { $0.id == rod.id }) == false {
                id_range.append(rod.id)
            }
        }
        
        return id_range
    }
    
    func getNodesIDRange() -> [Int] {
        let alreadySettedNodes = ConctructionDC.Nodes
        
        var id_range = [Int]()
        for i in 1...ConctructionDC.Rods.count+1 {
            if alreadySettedNodes.contains(where: { $0.id == i }) == false {
                id_range.append(i)
            }
        }

        return id_range
    }
    
    func deleteLinearLoad(with id: Int) {
        withAnimation {
            ConctructionDC.Loads.removeAll(where: { $0.id == id })
        }
    }
    
    func deleteNodeLoad(with id: Int) {
        withAnimation {
            ConctructionDC.Nodes.removeAll(where: { $0.id == id })
        }
    }
}

struct RodLoads_Previews: PreviewProvider {
    static var previews: some View {
        Loads(ConctructionDC: ConstructionDataController.preview)
    }
}
