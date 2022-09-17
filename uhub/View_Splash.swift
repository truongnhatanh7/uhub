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

struct SplashView: View {
    @EnvironmentObject var pageVM: PageViewModel
    @State var isActive:Bool = false
    @State var isShowAnimation:Bool = false
    
    
    /// This function will render the splash screen view
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .modifier(LogoSplashScreenModifier())
                .opacity(isShowAnimation ? 1.0 : 0.0)
                .animation(Animation.linear(duration: 2.0), value: isShowAnimation)
        }.onAppear {
            
            isShowAnimation = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                pageVM.visit(page: .SignUp)
            }
            
        }
    }
}
