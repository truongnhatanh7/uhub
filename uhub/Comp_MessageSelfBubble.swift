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

/// Message style for currently logged in user
struct MessageSelfBubble: View {
    var message: Message
    var body: some View {
        HStack {
            Text(message.content)
            Spacer()
            VStack {
                Spacer()
                Text(message.timestamp.getFormattedDate())
            }
        }
        .foregroundColor(Color("inverted_text_color"))
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color("pink_primary"))
        .modifier(CornerRadiusStyle(radius: 18, corners: [.topLeft, .bottomLeft, .bottomRight]))
        .padding(.leading, 24)

        
    }
}
