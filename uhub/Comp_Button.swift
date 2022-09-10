//
//  ButtonView.swift
//  uhub
//
//  Created by Andrew Le Nguyen on 02/09/2022.
//

import SwiftUI

struct ButtonView: View {
    @State var textContent: String
    var isDisabled: Bool = false
    var isSecondaryBtn: Bool = false
    @State var onTap: () -> ()

    
    var body: some View {
        if isDisabled {
            Button(action: {
                // action
                onTap()
            }, label:  {
                Text("\(textContent)").bold()
            })
            .buttonStyle(DisabledButtonStyle(isSecondaryBtn: isSecondaryBtn))
            .disabled(true)
        } else {
            Button(action: {
                // action
                onTap()
            }, label:  {
                Text("\(textContent)").bold()
            })
            .buttonStyle(PrimaryButtonStyle(isSecondaryBtn: isSecondaryBtn))
            .disabled(false)
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    var isSecondaryBtn: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(isSecondaryBtn ? Color("pink_primary") : .white)
            Spacer()
        }
        .padding()
        .background(
            isSecondaryBtn ? .clear :
            configuration.isPressed ?
            Color("pink_disabled")
            : Color("pink_primary")
        )
        .cornerRadius(30)
        .overlay(RoundedRectangle(cornerRadius: 30).stroke(isSecondaryBtn ? Color("pink_primary") : .clear, lineWidth: 4))
        .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct DisabledButtonStyle: ButtonStyle {
    var isSecondaryBtn: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(.white)
            Spacer()
        }
        .padding()
        .background(Color("pink_disabled"))
        .cornerRadius(30)
    }
}
