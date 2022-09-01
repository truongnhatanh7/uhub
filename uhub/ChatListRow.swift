//
//  ChatListRow.swift
//  uhub
//
//  Created by Truong Nhat Anh on 01/09/2022.
//

import SwiftUI

struct ChatListRow: View {
    @State var conversation: Conversation
    var body: some View {
        HStack {
            HStack {
                if conversation.imageURL == "" {
                    Text("")
                    frame(width: 50, height: 50)
                        .background(.primary)
                        .clipShape(Circle())
                        
                }
                VStack {
                    Text("Yasuo")
                    Text("Latest message")
                }
            }
            Spacer()
            VStack {
                Spacer()
                Text("20:00")
            }
        }
    }
}

struct ChatListRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatListRow(conversation: Conversation(imageURL: "", name: "Yasuo", latestMessage: "Slide the wind", timestamp: Date(), unread: true))
    }
}
