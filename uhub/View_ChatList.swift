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

struct ChatListView: View {
    @EnvironmentObject var chatEngine: ChatEngine
    @EnvironmentObject var imageManager: ImageManager
    @EnvironmentObject var notificationManger: NotiManager
    @EnvironmentObject var pageVM: PageViewModel
    @State var showMenu = false
    @State var searchText = ""
    @State var showAlert = false
    
    
    /// This function will filter the conversation
    var searchResults: [Conversation] {
        if searchText == ""  {
            return chatEngine.conversations
        }
        return chatEngine.conversations.filter({ $0.name.contains(searchText) })
    }
    
    /// Render the view for chat list
    var body: some View {
        VStack {
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
