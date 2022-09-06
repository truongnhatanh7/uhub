//
//  MessageSelfBubble.swift
//  uhub
//
//  Created by Truong Nhat Anh on 02/09/2022.
//

import SwiftUI

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
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color("pink_primary"))
        .foregroundColor(Color(.white))
        .modifier(CornerRadiusStyle(radius: 18, corners: [.topLeft, .bottomLeft, .bottomRight]))
        .padding(.leading, 24)
        
    }
}

//struct MessageSelfBubble_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageSelfBubble(message: Message(messageId: 1, ownerId: 1, conversationId: 1, content: "This is a test message with a very very very very very very very very very very very very very very long long long long long long long long long long long long long long long  text", timestamp: Date()))
//    }
//}
