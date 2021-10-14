//
//  Utils.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 14.10.2021.
//

import Combine
import SwiftUI

public struct NumberOnlyViewModifier: ViewModifier {

    @Binding var text: String
    let isPositiveOnly: Bool
    
    public init(text: Binding<String>, isPositiveOnly: Bool = true) {
        self._text = text
        self.isPositiveOnly = isPositiveOnly
    }

    public func body(content: Content) -> some View {
        content
            .onReceive(Just(text)) { newValue in
                let filtered = newValue.filter { "0123456789".contains($0) }
                if filtered != newValue {
                    self.text = filtered
                }
            }
    }
}
/*
extension TextField {
    func numberOnlyViewModifier() -> TextField {
        modifier(NumberOnlyViewModifier(text:   ))
    }
}
*/
