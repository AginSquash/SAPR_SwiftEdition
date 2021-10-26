//
//  SAPR_SwiftEditionApp.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 14.10.2021.
//

import SwiftUI

@main
struct SAPR_SwiftEditionApp: App {
    @ObservedObject var ConctructionDC = ConstructionDataController.preview
    @State private var showExport = false
    
    var body: some Scene {
        WindowGroup {
            MainView(ConctructionDC: ConctructionDC)
                .frame(width: 900, height: 700)
                .fileExporter(isPresented: $showExport, document: ConctructionDC.getSaprFile(), contentType: .data, defaultFilename: "SAPR_\(getDate())") { result in
                    switch result {
                    case .success(let url):
                        print("Saved to \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        }.commands {
            CommandGroup(after: CommandGroupPlacement.newItem) {
                Button("Save As") {
                    showExport = true
                }.keyboardShortcut("S")
            }
        }
    }
    
    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        return formatter.string(from: date)
    }
}
