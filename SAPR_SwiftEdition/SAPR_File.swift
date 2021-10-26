//
//  SAPR_File.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 26.10.2021.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

struct SAPR_File: Codable {
    var Rods: [Rod]
    var Loads: [LinearLoad]
    var Nodes: [Node]
    var Zadelka: SupportType
    
    init() {
        self.Rods = []
        self.Loads = []
        self.Nodes = []
        self.Zadelka = .Left
    }
}

struct SAPR_Document: FileDocument {
    
    static var readableContentTypes = [UTType.data]
    
    var sapr_file = SAPR_File()
    
    init(sapr: SAPR_File) {
        self.sapr_file = sapr
    }
    
    init() { }
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            if let decoded = try? JSONDecoder().decode(SAPR_File.self, from: data) {
                sapr_file = decoded
            }
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encoded = try JSONEncoder().encode(sapr_file)
        return FileWrapper(regularFileWithContents: encoded)
    }
    
    
}
