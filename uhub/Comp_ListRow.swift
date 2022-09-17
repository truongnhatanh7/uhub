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

struct ListRow: View {
    let icon: String
    let label: String
    var showNavigationIcon: Bool = true
    let action: () -> Void /// handle action

    /// View body
    var body: some View {
        Button(action: action) {
            VStack {
                HStack {
                    Image(systemName: icon)
                        .padding()
                        .foregroundColor(Color("pink_primary"))
                        .background(Color("pink_secondary"))
                        .clipShape(Circle())
                    Text(label)
                    Spacer()
                    if showNavigationIcon {
                        Image(systemName: "chevron.forward")
                            .foregroundColor(Color("pink_primary"))
                    }
                }.background(Color("background"))
                .padding(.vertical)
                
                Divider()
                 .frame(height: 1)
                 .padding(.horizontal, 30)
                 .background(Color("DarkGray"))
            }
            
            
       
            
        }.background(Color("background")).padding(.horizontal)
    }
}
