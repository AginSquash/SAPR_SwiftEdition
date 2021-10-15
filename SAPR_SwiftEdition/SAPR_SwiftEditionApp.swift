//
//  SAPR_SwiftEditionApp.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 14.10.2021.
//

import SwiftUI

@main
struct SAPR_SwiftEditionApp: App {
    var body: some Scene {
        WindowGroup {
            RodTableView()
                .frame(width: 700, height: 700)
        }
    }
}
