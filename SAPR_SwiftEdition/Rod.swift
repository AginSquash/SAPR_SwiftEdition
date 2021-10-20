//
//  Rod.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 14.10.2021.
//

import Foundation

struct Rod: Codable, Identifiable, Hashable {
    var id: Int
    var L: Float /// Length
    var A: Float /// Area
    var E: Float /// Elasticity
    var Sigma: Float /// Permissible voltage
    
    static func sample(with id: Int) -> Rod {
        Rod(id: id, L: 0, A: 0, E: 0, Sigma: 0)
    }
}
