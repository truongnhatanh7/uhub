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
    
    init(isRequired: Bool = false) {
        self.isRequired = isRequired
    }
    
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
    
    func body(content: Content) -> some View {
        content
            .focused($isFocused)
            .lineLimit(1)
            .multilineTextAlignment(.leading)
            .padding(.leading, 20)
    }
}

struct OneThirdModalStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity)
            .background(Color(uiColor: UIColor.tertiarySystemGroupedBackground))
            .cornerRadius(20)
            .transition(.move(edge: .bottom))
    }
}

struct LogoSplashScreenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.scaledToFit().frame(minWidth: 250, idealWidth: 280, maxWidth: 300).padding()
    }
}

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

struct TextTitle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(Font.system(size: 24).weight(.bold))
    }
}

struct DetailImage: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(minWidth: 400, idealWidth: 450, maxWidth: 480, minHeight: 550, idealHeight: 580, maxHeight: 600)
    }
}

struct CourseButton: ViewModifier {
    func body(content: Content) -> some View {
        content.padding(.vertical, 12).padding(.horizontal, 36).background(LinearGradient(gradient: Gradient(colors: [Color("pink_disabled"), Color("pink_primary")]), startPoint: .topLeading, endPoint: .bottomTrailing)).foregroundColor(.white).cornerRadius(32)
    }
}

struct CourseText: ViewModifier {
    func body(content: Content) -> some View {
        content.font(Font.system(size: 16).weight(.semibold))
    }
}

    


