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
    @State var currentLoadLimit: Int = 14;
    var newMessagesToBeLoaded: Int = 14
    
    var body: some View {
  
        ZStack {
            
            Color("black").edgesIgnoringSafeArea(.all)
            
            VStack {
                StandardHeader(title: "\(chatEngine.currentConversation?.name ?? "")") {
                    chatEngine.setRead()
                    chatEngine.fetchUserStatus()
                    pageVM.visit(page: .Chat)
                }
                
                
                if !chatEngine.isProcessing {
                    ScrollViewReader { proxy in
                        List {
                            ForEach(chatEngine.messages, id: \.self) { message in
                                if message.ownerId == (Auth.auth().currentUser?.uid ?? "-1") {
                                    MessageSelfBubble(message: message)
                                        .id(message.id)
                                        .listRowSeparator(.hidden)
                                        .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                                } else {
                                    MessageDefaultBubble(message: message)
                                        .id(message.id)
                                        .listRowSeparator(.hidden)
                                        .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4 , trailing: 16))
                                }
                            }
                        }.background(Color("black"))
                        .listStyle(PlainListStyle())
                        .onChange(of: chatEngine.lastMessageId) { id in
                            withAnimation {
                                proxy.scrollTo(id, anchor: .bottom)
                            }
                        }
                        .onAppear {
                            proxy.scrollTo(chatEngine.lastMessageId, anchor: .bottom)
                        }
                        .refreshable {
                            print("Refreshing...")
                            currentLoadLimit += newMessagesToBeLoaded
                            chatEngine.setCurrentLimit(limit: currentLoadLimit)
                            chatEngine.loadMessages()
                            
                        }
                    }

                } else {
                    VStack {
                        // Render blank space
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
                            .padding()
                            .tint(Color("pink_primary"))
                    }
                }
                .overlay(RoundedRectangle(cornerRadius: 18)
                    .stroke(Color("neutral"), lineWidth: 2)
                )
                .padding(.horizontal)
            }
            .onAppear {
                chatEngine.loadConversation()
            }
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
