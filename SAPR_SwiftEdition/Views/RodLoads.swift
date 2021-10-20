//
//  RodLoads.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 20.10.2021.
//

import SwiftUI

struct RodLoads: View {
    @Environment(\.colorScheme) var colorScheme
    
    static let column_width: CGFloat? = 125
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    //.foregroundColor(Color.init(red: 39/255, green: 80/255, blue: 171/255)) /// <- грязный цвет ахаха
                    .foregroundColor(Color.init(red: 0/255, green: 70/255, blue: 184/255))
                    .shadow(radius: 15)
                VStack {
                    HStack {
                        Text("Номер стержня")
                            .frame(width: RodLoads.column_width)
                        Text("Распределенная нагрузка")
                            .frame(width: RodLoads.column_width)
                    }.foregroundColor(.white)
                        Spacer()
                }
                .padding()
            }
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .foregroundColor(Color.init(red: 141/255, green: 49/255, blue: 171/255))
                     
                VStack {
                    HStack {
                        Text("Номер стержня")
                            .frame(width: RodLoads.column_width)
                        Text("Распределенная нагрузка")
                            .frame(width: RodLoads.column_width)
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
        RodLoads()
    }
}
