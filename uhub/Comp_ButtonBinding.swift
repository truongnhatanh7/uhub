//
//  ButtonWithBindingView.swift
//  uhub
//
//  Created by Andrew Le Nguyen on 04/09/2022.
//

import SwiftUI

struct ButtonBindingView: View {
    @State var textContent: String
    @State var onTap: () -> ()
    @Binding var isDisabled: Bool
    
    /// View body
    var body: some View {
        if isDisabled {
            Button(action: {
                // action handle
                onTap()
            }, label:  {
                Text("\(textContent)").bold()
            })
            .buttonStyle(DisabledButtonStyle())
            .disabled(true)
        } else {
            Button(action: {
                // action handle
                onTap()
            }, label:  {
                Text("\(textContent)").bold()
            })
            .buttonStyle(PrimaryButtonStyle())
            .disabled(false)
        }
    }
}
