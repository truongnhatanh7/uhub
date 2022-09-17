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

struct MatchCongrat: View {
    @Binding var showIsMatchUser: Bool
    @EnvironmentObject var chatEngine: ChatEngine
    @EnvironmentObject var pageVm: PageViewModel
    @EnvironmentObject var userAuthManager: UserAuthManager
    @State var userId: String
    
    /// This function will render the the match congrat when you swipe right and match with another person
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all).opacity(0.7)
            
            // MARK: Modal
            VStack(spacing: 24) {
                Image("CongratsIcon").resizable().modifier(CongratsLogoStyle())
                Text("Great! It's a match.")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .modifier(CongratsTextStyle())
                
                Text("Don't keep them waiting, say hello now!")
                    .font(.system(size: 16))
                    .modifier(CongratsTextStyle())
                
                Button {
                    chatEngine.createConversation(recipientId: userId) { newConversationId, willFetch in
                        if willFetch {
                            chatEngine.fetchConversationForCreation(toBeFetchedConversationId: newConversationId) {
                                showIsMatchUser = false
                                pageVm.visit(page: .Inbox)
                            }
                        } else {
                            showIsMatchUser = false
                            pageVm.visit(page: .Inbox)
                        }
                    }
                } label: {
                    VStack {
                        Text("Go to Chat")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                    }
                    .modifier(CongratsButtonStyle())
                }
                
            }
            .modifier(ModalStyle())
            .onAppear {
                chatEngine.userAuthManager = self.userAuthManager
                if let isShowNewMatchNoti = (userAuthManager.currentUserData["isShowNewMatchNoti"]) {
                    if isShowNewMatchNoti as! Bool {
                        playMusic(sound: "match", isLoop: false)
                    }
                    
                }
            }
        }
    }
}
