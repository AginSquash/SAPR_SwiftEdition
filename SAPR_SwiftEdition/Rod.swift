//
//  Rod.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 14.10.2021.
//

import Foundation

struct Rod: Codable, Identifiable, Hashable {
    let id: Int
    let L: Float /// Length
    let A: Float /// Area
    let E: Float /// Elasticity
    let Sigma: Float /// Permissible voltage
}
