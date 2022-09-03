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
                        ChatListRow(conversation: conversation)
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear() {
            chatEngine.loadChatList()
        }
        .onTapGesture {
            pageVM.visit(page: .Inbox)
        }
    }

}

//struct ChatList_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatList(conversations:)
//    }
//}