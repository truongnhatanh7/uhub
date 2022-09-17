//
//  ChatList.swift
//  uhub
//
//  Created by Truong Nhat Anh on 01/09/2022.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var chatEngine: ChatEngine
    @EnvironmentObject var imageManager: ImageManager
    @EnvironmentObject var notificationManger: NotiManager
    @EnvironmentObject var pageVM: PageViewModel
    @State var showMenu = false
    @State var searchText = ""
    @State var showAlert = false
    
    
    /// This function will filter the conversation
    var searchResults: [Conversation] {
        if searchText == ""  {
            return chatEngine.conversations
        }
        return chatEngine.conversations.filter({ $0.name.contains(searchText) })
    }
    
    /// Render the view for chat list
    var body: some View {
        VStack {
            VStack {
                TextInputComponent(value: $searchText, placeholder: "Search", isSecure: false, isRequired: false, icon: "magnifyingglass")
            }.padding()
            
            ScrollView {
                ForEach(searchResults, id: \.self) { conversation in
                    Button {
                        chatEngine.currentConversation = conversation
                        chatEngine.setRead()
                        pageVM.visit(page: .Inbox)
                    } label: {
                        ChatListRow(conversation: conversation)
                    }
                    .foregroundColor(.black)
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 8)
                
            }
            
            if showMenu {
                BottomBar {
                    MenuBar(menuInPage: .Chat, showMenu: $showMenu)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            chatEngine.notificationManager = notificationManger
            withAnimation {
                showMenu = true
            }
        }
    }
}
