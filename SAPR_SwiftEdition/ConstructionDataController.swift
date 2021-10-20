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
    init(inMemory: Bool = false) {
        if inMemory {
            self.Rods = [Rod(id: 1, L: 10, A: 2.1, E: 1.1, Sigma: 1.5), Rod(id: 2, L: 20, A: 61, E: 31, Sigma: 1.5)]
            self.Loads = [LinearLoad(id: 1, q: 10), LinearLoad(id: 2, q: -20)]
        } else {
            self.Rods = []
            self.Loads = []
        }
    }
    
    static var preview: ConstructionDataController = {
        let cdc = ConstructionDataController(inMemory: true)
        return cdc
    }()
}
