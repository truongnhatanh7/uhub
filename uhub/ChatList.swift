//
//  ChatList.swift
//  uhub
//
//  Created by Truong Nhat Anh on 01/09/2022.
//

import SwiftUI

struct ChatList: View {
    var conversations: [Conversation]
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
                ForEach(conversations, id: \.self) { conversation in
                        ChatListRow(conversation: conversation)
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList(conversations: [
            Conversation(conversationId: 1, imageURL: "", name: "Credence Nguyen", latestMessage: "How are you doing lorem ipsum lorem rem", timestamp: Date(), unread: true),
            Conversation(conversationId: 2, imageURL: "", name: "Credence Nguyen", latestMessage: "How are you doing lorem ipsum lorem rem", timestamp: Date(), unread: true),
            Conversation(conversationId: 3, imageURL: "", name: "Credence Nguyen", latestMessage: "How are you doing lorem ipsum lorem rem", timestamp: Date(), unread: true),
            Conversation(conversationId: 1, imageURL: "", name: "Credence Nguyen", latestMessage: "How are you doing lorem ipsum lorem rem", timestamp: Date(), unread: true),
            Conversation(conversationId: 1, imageURL: "", name: "Credence Nguyen", latestMessage: "How are you doing lorem ipsum lorem rem", timestamp: Date(), unread: true),
            Conversation(conversationId: 1, imageURL: "", name: "Credence Nguyen", latestMessage: "How are you doing lorem ipsum lorem rem", timestamp: Date(), unread: true),
            Conversation(conversationId: 1, imageURL: "", name: "Credence Nguyen", latestMessage: "How are you doing lorem ipsum lorem rem", timestamp: Date(), unread: true)
            
        ])
    }
}
