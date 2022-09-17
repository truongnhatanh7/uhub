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
    
    var searchResults: [Conversation] {
        if searchText == ""  {
            return chatEngine.conversations
        }
        return chatEngine.conversations.filter({ $0.name.contains(searchText) })
    }
    
    var body: some View {
        VStack {
//            ZStack {
//                TextField("Search", text: $searchText)
//                    .padding()
//                    .background(Color("neutral"))
//                    .clipShape(RoundedRectangle(cornerRadius: 80))
//                    .frame(maxHeight: 80)
//                    .padding(.horizontal, 8)
//                HStack {
//                    Spacer()
//                    Image(systemName: "magnifyingglass")
//                        .padding(.trailing, 28)
//                }
//            }
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

//struct ChatList_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatList(conversations:)
//    }
//}
