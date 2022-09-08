//
//  ChatListRow.swift
//  uhub
//
//  Created by Truong Nhat Anh on 01/09/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ChatListRow: View {
    @EnvironmentObject var chatEngine: ChatEngine
    @State var conversation: Conversation
//    @State var isActive: Bool = false
    var body: some View {
        HStack {
            HStack {
                ZStack {
                    // TODO: Add condition for rendering images
                    
                        // TODO: Load real img

                    AsyncImage(url: URL(string: "https://vnn-imgs-a1.vgcloud.vn/image1.ictnews.vn/_Files/2020/03/17/trend-avatar-1.jpg"), scale: 1) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } placeholder: {
                        Text("")
                            .frame(width: 50, height: 50)
                            .background(Color("pink_primary"))
                            .clipShape(Circle())
                    }

                    // TODO: Handle online -> Green light
//                    if isActive {
//
//                        Text("") // Active status
//                            .frame(width: 12, height: 12)
//                            .background(.gray)
//                            .clipShape(Circle())
//                            .padding(.leading, 36)
//                            .padding(.top, 36)
//
//                    }


                    
                }

                VStack(alignment: .leading) {
                    // TODO: update when database has name
                    Text(conversation.name)
                        .fontWeight(.medium)
                    Spacer()
                    if Auth.auth().currentUser?.uid != conversation.latestMessageSender && conversation.unread {
                        Text(conversation.latestMessage)
                            .fontWeight(.bold)
                    } else {
                        Text(conversation.latestMessage)
                    }
                    

                }
                .padding(.leading, 8)
                
            }
            Spacer()
            VStack {
                if Auth.auth().currentUser?.uid != conversation.latestMessageSender && conversation.unread {
                    Text("")
                        .frame(width: 16, height: 16)
                        .foregroundColor(.white)
                        .background(Color("pink_primary"))
                        .clipShape(Circle())
                }
                Spacer()
                Text(conversation.timestamp.getFormattedDate())
            }
        }
        .padding()
        .frame(maxHeight: 80)
        .overlay(RoundedRectangle(cornerRadius: 18)
            .stroke(Color("neutral"), lineWidth: 1)
        )
        .onAppear {
//            let db = Firestore.firestore()
//            db.collection("users").document(conversation.users.filter({ $0 != Auth.auth().currentUser?.uid }).first!).getDocument { (document, error) in
//                if let document = document, document.exists {
//                    let data = document.data()
//
//                    let status = data?["isActive"] as? Bool ?? false
//                    print("\(document.documentID) => \(status)")
//                    self.isActive = status
//                } else {
//                    print("Document does not exist")
//                }
//            }
        }
        
    }
}

//struct ChatListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatListRow(conversation: Conversation(conversationId: 1, imageURL: "", name: "Credence Nguyen", latestMessage: "How are you doing lorem ipsum lorem rem", timestamp: Date(), unread: true))
//    }
//}
