//
//  MessageDefaultBubble.swift
//  uhub
//
//  Created by Truong Nhat Anh on 02/09/2022.
//

import SwiftUI


struct MessageDefaultBubble: View {
    var message: Message
    var body: some View {
        HStack {
            Text(message.content)
            Spacer()
            VStack {
                Spacer()
                Text(message.getFormattedDate())
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity)
        .padding()
        .background(.gray)
        .modifier(CornerRadiusStyle(radius: 18, corners: [.topRight, .bottomLeft, .bottomRight]))
        .padding(.trailing, 24)
        
    }
}

struct MessageDefaultBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageDefaultBubble(message: Message(messageId: 1, ownerId: 1, conversationId: 1, content: "This is a test message with a very very very very very very very very very very very very very very long long long long long long long long long long long long long long long  text", timestamp: Date()))
    }
}
