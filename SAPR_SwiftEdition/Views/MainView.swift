//
//  MainView.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 20.10.2021.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var ConctructionDC: ConstructionDataController
    @State private var selected: Int? = 0
    
    var body: some View {
        NavigationView {
            List(selection: $selected) {
                Section(header: Text("Ввод данных")) {
                    NavigationLink("Стержни", destination: RodTableView(ConctructionDC: ConctructionDC))
                        .tag(0)
                    NavigationLink("Нагрузки", destination: Loads(ConctructionDC: ConctructionDC))
                        .tag(1)
                }
            }
            Text("Select a Note")
        }.toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar, label: {
                    Image(systemName: "sidebar.leading")
                })
            }
        }
    }
    
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(ConctructionDC: .preview)
    }
}
