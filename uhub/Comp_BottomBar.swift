//
//  BottomBar.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 06/09/2022.
//

import SwiftUI

struct BottomBar<T: View>: View {
    let content: () -> T

    init(@ViewBuilder content: @escaping () -> T) {
        self.content = content
    }
    
    var body: some View {
        VStack {
            content()
        }
        .modifier(OneThirdModalStyle())
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.secondary)
                .opacity(0.4)
        )
    }
}
