//
//  ChatListRow.swift
//  uhub
//
//  Created by Truong Nhat Anh on 01/09/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct ChatListRow: View {
    @EnvironmentObject var chatEngine : ChatEngine
    @EnvironmentObject var imageManager: ImageManager
    @State var conversation: Conversation
    @State var uiImage: UIImage? 
    @State var imageIsLoaded: Bool = false
    @State var showDeleteAlert: Bool = false
    @State var offset = CGSize.zero
    var body: some View {
        HStack {
            HStack {
                ZStack {
                    if let uiImage = uiImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } else {
                        Text("")
                            .frame(width: 50, height: 50)
                            .background(Color("pink_primary"))
                            .clipShape(Circle())
                    }

                    if chatEngine.conversationStatus[conversation.users.filter({ $0 != Auth.auth().currentUser?.uid }).first!] ?? false {
                        Text("") // Active status
                            .frame(width: 12, height: 12)
                            .background(Color("pink_primary"))
                            .clipShape(Circle())
                            .padding(.leading, 36)
                            .padding(.top, 36)

                    } else {
                        Text("") // Inactive status
                            .frame(width: 12, height: 12)
                            .background(.gray)
                            .clipShape(Circle())
                            .padding(.leading, 36)
                            .padding(.top, 36)
                    }
                }

                VStack(alignment: .leading) {
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
        .foregroundColor(Color("black_primary"))
        .padding()
        .frame(maxHeight: 80)
        .overlay(RoundedRectangle(cornerRadius: 18)
            .stroke(Color("neutral"), lineWidth: 1)
        )
        .onAppear {
            chatEngine.imageManager = imageManager
            chatEngine.fetchUserImage(conversation: conversation) { img in
                self.uiImage = img
            }
        }
        .alert(isPresented: $showDeleteAlert) { () -> Alert in
            Alert(title: Text("Delete this conversation"), message: Text("Do you want to delete the conversation with \(conversation.name)"), primaryButton: .default(Text("Cancel"), action: {
                withAnimation {
                    offset = .zero
                }
            }), secondaryButton: .destructive(Text("Delete"), action: {
                withAnimation {
                    chatEngine.deleteConversation(id: conversation.conversationId)
                }
            }))
        }
//        .onLongPressGesture {
//            showDeleteAlert = true
//        }
    }
        
        
        
}

//struct ChatListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatListRow(conversation: Conversation(conversationId: 1, imageURL: "", name: "Credence Nguyen", latestMessage: "How are you doing lorem ipsum lorem rem", timestamp: Date(), unread: true))
//    }
//}
