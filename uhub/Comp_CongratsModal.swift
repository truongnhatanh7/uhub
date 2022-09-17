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

struct CongratsModal: View {
    @Binding var isGoToHome:Bool
    
    /// View body
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all).opacity(0.7)
            
            // MARK: Modal
            VStack(spacing: 24) {
                
                Image("CongratsIcon").resizable().modifier(CongratsLogoStyle())
                
                
                Text("Great \n Your account has been \n created successfully").fontWeight(.bold).font(.system(size: 24)).modifier(CongratsTextStyle())
                
                Button(action: { isGoToHome = true }) {
                    VStack {
                        Text("Go to Home").fontWeight(.semibold).font(.system(size: 20))
                    }.modifier(CongratsButtonStyle())
                }
                
            }
            .modifier(ModalStyle())
        }
    }
}
