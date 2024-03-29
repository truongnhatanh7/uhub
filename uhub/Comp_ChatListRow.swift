/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Authors:
 + S3877980 - Ho Le Minh Thach
 + S3878231 - Truong Nhat Anh
 + S3877698 - Nguyen Luu Quoc Bao
 + S3820098  - Le Nguyen Truong An
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgements: Learning from Hacking with Swift to implement MVVM, and the usage of CoreData
 Hudson, P. (n.d.). The 100 days of Swiftui. Hacking with Swift. Retrieved July 30, 2022, from https://www.hackingwithswift.com/100/swiftui
*/

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
    var body: some View {
        HStack {
            HStack {
                ZStack {
                    /// Avatar
                    if let uiImage = uiImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } else {
                        /// Placeholder
                        Text("")
                            .frame(width: 50, height: 50)
                            .background(Color("pink_primary"))
                            .clipShape(Circle())
                    }
                    
                    
                    /// Online status
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
                
                /// Chat information
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
            /// New message indicator
            VStack {
                if Auth.auth().currentUser?.uid != conversation.latestMessageSender && conversation.unread {
                    Text("")
                        .frame(width: 16, height: 16)
                        .foregroundColor(.white)
                        .background(Color("pink_primary"))
                        .clipShape(Circle())
                }
                Spacer()
                /// Timestamp
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
            /// Handle chat engine logic
            chatEngine.imageManager = imageManager
            chatEngine.fetchUserImage(conversation: conversation) { img in
                self.uiImage = img
            }
        }
    }
    
    
    
}
