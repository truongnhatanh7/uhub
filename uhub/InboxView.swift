//
//  InboxView.swift
//  uhub
//
//  Created by Truong Nhat Anh on 02/09/2022.
//

import SwiftUI

var currentUserId = 1 // For view testing purpose, TODO: Delete this after implemented Firebase

struct InboxView: View {
    var messages: [Message]
    @State var textBoxContent: String = ""
    var body: some View {
        VStack {
            ScrollView {
                ForEach(messages, id: \.self) { message in
                    if message.ownerId == currentUserId {
                        MessageSelfBubble(message: message)
                    } else {
                        MessageDefaultBubble(message: message)
                    }
                        
                }
                .padding(.horizontal)
            }
            HStack {
                TextField("Send message", text: $textBoxContent)
                    .lineLimit(3)
                    .padding()
                    Spacer()
                    Image(systemName: "paperplane")
                    .padding()
            }
            .overlay(RoundedRectangle(cornerRadius: 18)
                .stroke(lineWidth: 1)
            )
            .padding(.horizontal)
            
        }
        
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView(messages: [
            Message(messageId: 1, ownerId: 1, conversationId: 1, content: "This is a test message with a very very very very very very very very very very very very very very long long long long long long long long long long long long long long long  text", timestamp: Date()),
            Message(messageId: 1, ownerId: 2, conversationId: 1, content: "This #1 text is from other user", timestamp: Date()),
            Message(messageId: 1, ownerId: 2, conversationId: 1, content: "This #2 text is from other user", timestamp: Date()),
            Message(messageId: 1, ownerId: 2, conversationId: 1, content: "This #3 text is from other user", timestamp: Date()),
            Message(messageId: 1, ownerId: 1, conversationId: 1, content: "This is a test message with a very very very very very very very very very very very very very very long long long long long long long long long long long long long long long  text", timestamp: Date()),
            Message(messageId: 1, ownerId: 1, conversationId: 1, content: "This is a test message with a very very very very very very very very very very very very very very long long long long long long long long long long long long long long long  text", timestamp: Date())
        ])
    }
}
