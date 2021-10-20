//
//  BackgroundColorHelper.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 20.10.2021.
//

import SwiftUI

func getBackColor(with id: Int, colorScheme: ColorScheme) -> Color {
    if id % 2 == 0 {
        if colorScheme == .light {
            return Color.init(red: 255/255, green: 255/255, blue: 255/255)
        } else {
            return Color.init(red: 35/255, green: 35/255, blue: 40/255)
        }
    } else {
        if colorScheme == .light {
            return Color.init(red: 244/255, green: 245/255, blue: 245/255)
        } else {
            return Color.init(red: 45/255, green: 45/255, blue: 50/255)
        }
    }
}
