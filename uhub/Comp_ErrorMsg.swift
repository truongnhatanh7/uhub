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

struct ErrorMsgView: View {
    @State var msg: String
    
    /// View body
    var body: some View {
        HStack {
            SideIcon(
                iconName: "info.circle.fill",
                iconColor: Color("red_danger")
            )
            
            Text("\(msg)")
                .font(.system(size: 14))
                .foregroundColor(Color("red_danger"))
            
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color("pink_disabled").opacity(0.25))
                .cornerRadius(30)
        )
    }
}

/// SideIcon
struct SideIcon: View {
    private var iconName: String
    private var iconColor: Color
    
    init(iconName: String, iconColor: Color) {
        self.iconName = iconName
        self.iconColor = iconColor
    }
    
    var body: some View {
        Image(systemName: iconName)
            .foregroundColor(iconColor)
    }
}
