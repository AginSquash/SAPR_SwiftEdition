//
//  ContructionSupport.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 26.10.2021.
//

import Foundation

enum SupportType: Int, Codable {
    case Left = 0
    case Right = 1
    case Both = 2
    
    init(rawValue: Int) {
        switch rawValue {
        case 0: self = .Left
        case 1: self = .Right
        case 2: self = .Both
        default:
            self = .Left
        }
    }
}
