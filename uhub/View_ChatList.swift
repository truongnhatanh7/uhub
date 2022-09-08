//
//  ChatList.swift
//  uhub
//
//  Created by Truong Nhat Anh on 01/09/2022.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var chatEngine: ChatEngine
    @EnvironmentObject var pageVM: PageViewModel
    @State var showMenu = false
    @State var searchText = ""
    var body: some View {
        VStack {
            ZStack {
                TextField("Search", text: $searchText)
                    .padding()
                    .background(Color("neutral"))
                    .clipShape(RoundedRectangle(cornerRadius: 80))
                    .frame(maxHeight: 80)
                    .padding(.horizontal, 8)
                HStack {
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .padding(.trailing, 28)
                        
                }
            }

            ScrollView {
                ForEach(chatEngine.conversations, id: \.self) { conversation in
                    Button {
                        chatEngine.currentConversation = conversation.conversationId
                        chatEngine.currentUnread = conversation.unread
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
        .onAppear() {
            chatEngine.loadChatList()
            print(chatEngine.conversations)
            withAnimation { showMenu = true }
        }
    }

}

//struct ChatList_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatList(conversations:)
//    }
//}
