//
//  ChatListRow.swift
//  uhub
//
//  Created by Truong Nhat Anh on 01/09/2022.
//

import SwiftUI

struct ChatListRow: View {
    var conversation: Conversation
    var body: some View {
        HStack {
            HStack {
                ZStack {
                    if conversation.imageURL == "" {
                        // TODO: Load default img (no avatar)
                        Text("")
                            .frame(width: 50, height: 50)
                            .background(.red)
                            .clipShape(Circle())
                    } else {
                        // TODO: Load real img
                    }
                    
                    // TODO: Handle online -> Green light
                    Text("") // Active status
                        .frame(width: 12, height: 12)
                        .background(.gray)
                        .clipShape(Circle())
                        .padding(.leading, 36)
                        .padding(.top, 36)
                    
                }

                VStack(alignment: .leading) {
                    Text(conversation.name)
                        .fontWeight(.medium)
                    Spacer()
                    Text(conversation.latestMessage)

                }
                .padding(.leading, 8)
                
            }
            Spacer()
            VStack {
                Text("2")
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .background(.red)
                    .clipShape(Circle())
                Spacer()
                Text("20:00")
            }
        }
        .padding()
        .frame(maxHeight: 80)
        .overlay(RoundedRectangle(cornerRadius: 18)
            .stroke(.gray, lineWidth: 1)
        )
        
    }
}

struct ChatListRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatListRow(conversation: Conversation(conversationId: 1, imageURL: "", name: "Credence Nguyen", latestMessage: "How are you doing lorem ipsum lorem rem", timestamp: Date(), unread: true))
    }
}