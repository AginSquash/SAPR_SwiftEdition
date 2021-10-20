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
        self.Rods = []
        self.Loads = []
    }
    
    static var preview: ConstructionDataController = {
        let cdc = ConstructionDataController(inMemory: true)
        return cdc
    }()
}
