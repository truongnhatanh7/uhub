/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Authors:
 + S3877980 - Ho Le Minh Thach
 + S3878231 - Truong Nhat Anh
 + S3877698 - Nguyen Luu Quoc Bao
 + S3820098  - Le Nguyen Truong An
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgements: Learning from Hacking with Swift to implement MVVM, and the usage of CoreData
 Hudson, P. (n.d.). The 100 days of Swiftui. Hacking with Swift. Retrieved July 30, 2022, from https://www.hackingwithswift.com/100/swiftui
*/

import SwiftUI
import Firebase

struct InboxView: View {
    @EnvironmentObject var chatEngine: ChatEngine
    @EnvironmentObject var userAuthManager: UserAuthManager
    @EnvironmentObject var pageVM: PageViewModel
    @State var textBoxContent: String = ""
    @State var currentLoadLimit: Int = 14;
    var newMessagesToBeLoaded: Int = 14
    
    /// This function will render the view inbox where you will have coversation
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
                                currentLoadLimit += newMessagesToBeLoaded
                                chatEngine.setCurrentLimit(limit: currentLoadLimit)
                                chatEngine.loadMessages()
                            }
                    }
                } else {
                    VStack {}
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
        .onAppear {
            chatEngine.userAuthManager = self.userAuthManager
            chatEngine.loadConversation()
        }
    }
}
