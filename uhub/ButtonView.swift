//
//  ButtonView.swift
//  uhub
//
//  Created by Andrew Le Nguyen on 02/09/2022.
//

import SwiftUI

struct ButtonView: View {
    @State var textContent: String
    @State var onTap: () -> ()
    @State var isDisabled: Bool?
    
    var body: some View {
        if isDisabled ?? false {
            Button(action: {
                // action
                onTap()
            }, label:  {
                Text("\(textContent)").bold()
            })
            .buttonStyle(DisabledButtonStyle())
            .disabled(true)
        } else {
            Button(action: {
                // action
                onTap()
            }, label:  {
                Text("\(textContent)").bold()
            })
            .buttonStyle(PrimaryButtonStyle())
            .disabled(false)
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(.white)
            Spacer()
        }
        .padding()
        .background(
            configuration.isPressed ?
            Color("pink_disabled")
            : Color("pink_primary")
        )
        .cornerRadius(30)
        .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct DisabledButtonStyle: ButtonStyle {
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

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ButtonView(textContent: "Sign In", onTap: {})
            ButtonView(textContent: "Sign Up", onTap: {}, isDisabled: true)
        }
    }
}

