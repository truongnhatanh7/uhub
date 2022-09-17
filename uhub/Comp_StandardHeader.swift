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

/// Standard Header
struct StandardHeader: View {
    @EnvironmentObject var pageMV: PageViewModel
    let title: String
    var showReturn: Bool = true
    let action: () -> Void
    
    /// View body
    var body: some View {
        HStack {
            if showReturn {
                Button(action: action) {
                    Label("Back", systemImage: "arrow.left")
                        .labelStyle(.iconOnly)
                        .tint(Color("pink_primary"))
                }
            }
            Text(title).font(.headline)
            Spacer()
        }
        .padding()
        .background(Color("background"))
    }
}
