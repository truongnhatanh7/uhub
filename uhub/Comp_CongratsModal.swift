/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Nguyen Luu Quoc Bao
 ID: s3877698
 Created  date: 01/09/2022
 Last modified: 01/09/2022
 Acknowledgement: None
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
