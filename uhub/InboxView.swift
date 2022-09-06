//
//  InboxView.swift
//  uhub
//
//  Created by Truong Nhat Anh on 02/09/2022.
//

import SwiftUI
import Firebase

struct InboxView: View {
    @EnvironmentObject var chatEngine: ChatEngine
    @EnvironmentObject var pageVM: PageViewModel
    @State var textBoxContent: String = ""
    
    var body: some View {
        VStack {
            StandardHeader(title: "Inbox") {
                pageVM.visit(page: .Chat)
            }
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(chatEngine.messages, id: \.self) { message in
                        if message.ownerId == (Auth.auth().currentUser?.uid ?? "-1") {
                            MessageSelfBubble(message: message)
                                .id(message.id)
                        } else {
                            MessageDefaultBubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding(.horizontal)
                }
                .onChange(of: chatEngine.lastMessageId) { id in
                    withAnimation {
                        proxy.scrollTo(id, anchor: .bottom)
                    }
                }
                .onAppear {
                    proxy.scrollTo(chatEngine.lastMessageId, anchor: .bottom)
                }
            }

            HStack {
                TextField("Send message", text: $textBoxContent)
                    .lineLimit(3)
                    .padding()
                    Spacer()
                Button {
                    chatEngine.sendMessage(content: textBoxContent)
                    textBoxContent = ""
                } label: {
                    Image(systemName: "paperplane")
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 18)
                .stroke(Color("neutral"), lineWidth: 2)
            )
            .padding(.horizontal)
            
        }
        .onAppear {
            print(chatEngine.currentConversation)
            chatEngine.loadConversation()
        }
        
    }
}

//struct InboxView_Previews: PreviewProvider {
//    static var previews: some View {
//        InboxView(messages: [
//            Message(messageId: 1, ownerId: 1, conversationId: 1, content: "This is a test message with a very very very very very very very very very very very very very very long long long long long long long long long long long long long long long  text", timestamp: Date()),
//            Message(messageId: 1, ownerId: 2, conversationId: 1, content: "This #1 text is from other user", timestamp: Date()),
//            Message(messageId: 1, ownerId: 2, conversationId: 1, content: "This #2 text is from other user", timestamp: Date()),
//            Message(messageId: 1, ownerId: 2, conversationId: 1, content: "This #3 text is from other user", timestamp: Date()),
//            Message(messageId: 1, ownerId: 1, conversationId: 1, content: "This is a test message with a very very very very very very very very very very very very very very long long long long long long long long long long long long long long long  text", timestamp: Date()),
//            Message(messageId: 1, ownerId: 1, conversationId: 1, content: "This is a test message with a very very very very very very very very very very very very very very long long long long long long long long long long long long long long long  text", timestamp: Date())
//        ])
//    }
//}
