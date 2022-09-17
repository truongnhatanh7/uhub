//
//  MessageSelfBubble.swift
//  uhub
//
//  Created by Truong Nhat Anh on 02/09/2022.
//

import SwiftUI

/// Message style for currently logged in user
struct MessageSelfBubble: View {
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
        .foregroundColor(Color("inverted_text_color"))
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color("pink_primary"))
        .modifier(CornerRadiusStyle(radius: 18, corners: [.topLeft, .bottomLeft, .bottomRight]))
        .padding(.leading, 24)

        
    }
}
