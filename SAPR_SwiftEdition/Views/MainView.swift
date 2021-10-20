//
//  MainView.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 20.10.2021.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var ConctructionDC = ConstructionDataController()
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("RodTableView", destination: RodTableView(ConctructionDC: ConctructionDC))
                NavigationLink("ContentView", destination: ContentView())
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
        MainView()
    }
}
