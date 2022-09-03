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
                    // TODO: Add condition for rendering images
                    Text("")
                        .frame(width: 50, height: 50)
                        .background(Color("pink_primary"))
                        .clipShape(Circle())
                    
                        // TODO: Load real img
                    
                    
                    // TODO: Handle online -> Green light
                    Text("") // Active status
                        .frame(width: 12, height: 12)
                        .background(.gray)
                        .clipShape(Circle())
                        .padding(.leading, 36)
                        .padding(.top, 36)
                    
                }

                VStack(alignment: .leading) {
                    // TODO: update when database has name
//                    Text(conversation.name)
//                        .fontWeight(.medium)
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
                    .background(Color("pink_primary"))
                    .clipShape(Circle())
                Spacer()
                Text(conversation.timestamp.getFormattedDate())
            }
        }
        .padding()
        .frame(maxHeight: 80)
        .overlay(RoundedRectangle(cornerRadius: 18)
            .stroke(Color("neutral"), lineWidth: 1)
        )
        
    }
}

//struct ChatListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatListRow(conversation: Conversation(conversationId: 1, imageURL: "", name: "Credence Nguyen", latestMessage: "How are you doing lorem ipsum lorem rem", timestamp: Date(), unread: true))
//    }
//}
