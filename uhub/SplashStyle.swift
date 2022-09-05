//
//  SplashScreenModifier.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 01/09/2022.
//

import SwiftUI

struct LogoSplashScreenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.scaledToFit().frame(minWidth: 250, idealWidth: 280, maxWidth: 300).padding()
    }
}
