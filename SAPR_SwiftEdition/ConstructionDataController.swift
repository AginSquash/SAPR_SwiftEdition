//
//  ConstructionDataController.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 20.10.2021.
//

import SwiftUI

class ConstructionDataController: ObservableObject {
    @Published var Rods: [Rod]
    @Published var Loads: [LinearLoad]
    @Published var Nodes: [Node]
    @Published var Zadelka: SupportType
    
    init(inMemory: Bool = false) {
        if inMemory {
            self.Rods = [Rod(id: 1, L: 10, A: 2.1, E: 1.1, Sigma: 1.5), Rod(id: 2, L: 20, A: 61, E: 31, Sigma: 1.5)]
            self.Loads = [LinearLoad(id: 1, q: 10), LinearLoad(id: 2, q: -20)]
            self.Nodes = [Node(id: 1, F: -5.0), Node(id: 2, F: 3.0)]
            self.Zadelka = .Left
        } else {
            self.Rods = []
            self.Loads = []
            self.Nodes = []
            self.Zadelka = .Left
        }
    }
    
    static var preview: ConstructionDataController = {
        let cdc = ConstructionDataController(inMemory: true)
        return cdc
    }()
    
    func getSaprFile() -> SAPR_Document {
        var file = SAPR_File()
        
        file.Rods = self.Rods
        file.Loads = self.Loads
        file.Nodes = self.Nodes
        file.Zadelka = self.Zadelka
        
        let document = SAPR_Document(sapr: file)
        return document
    }
}
