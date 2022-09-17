//
//  MessageDefaultBubble.swift
//  uhub
//
//  Created by Truong Nhat Anh on 02/09/2022.
//

import SwiftUI

/// Message for user that is not this current user
struct MessageDefaultBubble: View {
    var message: Message
    var body: some View {
        HStack {
            Text(message.content)
            Spacer()
            VStack {
                Spacer()
                Text(message.timestamp.getFormattedDate())
            }
        }
        .foregroundColor(Color(.black))
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color("neutral"))
        .modifier(CornerRadiusStyle(radius: 18, corners: [.topRight, .bottomLeft, .bottomRight]))
        .padding(.trailing, 24)

    }
}
