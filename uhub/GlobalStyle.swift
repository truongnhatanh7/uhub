//
//  GlobalStyle.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 03/09/2022.
//

import Foundation
import SwiftUI

struct LabelStyle: ViewModifier {
    let isRequired: Bool
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 20)
            .overlay(alignment: .topTrailing) {
                isRequired ?
                Text("*")
                    .foregroundColor(.red)
                    .padding(.trailing, 12)
                : nil
            }
    }
}

struct InputStyle: ViewModifier {
    @FocusState<Bool>.Binding var isFocused: Bool
    @Binding var focusTracker: Bool
    
    func body(content: Content) -> some View {
        content
            .focused($isFocused)
            .onChange(of: isFocused) { focusTracker = $0 }
            .lineLimit(1)
            .multilineTextAlignment(.leading)
            .padding(.leading, 20)
    }
}
