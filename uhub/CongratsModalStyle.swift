//
//  CongratsModalStyle.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 05/09/2022.
//

import SwiftUI

struct CongratsLogoStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.scaledToFit().frame(minWidth: 170, idealWidth: 180, maxWidth: 190, minHeight: 180, idealHeight: 186, maxHeight: 190)
    }
}

struct CongratsTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.multilineTextAlignment(TextAlignment.center).lineLimit(3).foregroundColor(Color("pink_primary")).lineSpacing(10)
    }
}

struct CongratsButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(minWidth: 285, idealWidth: 292, maxWidth: 300, minHeight: 50, idealHeight: 55, maxHeight: 60).background(LinearGradient(gradient: Gradient(colors: [Color("pink_disabled"), Color("pink_primary")]), startPoint: .topLeading, endPoint: .bottomTrailing)).foregroundColor(.white).cornerRadius(32)
    }
}

struct ModalStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(minWidth: 320, idealWidth: 350, maxWidth: 360, minHeight: 450, idealHeight: 460, maxHeight: 480).background(.white).cornerRadius(24).padding()
    }
}

    

    

  

