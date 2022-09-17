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

struct AvatarInput: View {
    let image: Image?
    let action: () -> Void
    
    /// init
    /// - Parameters:
    ///   - image: Image
    ///   - action: func
    init(image: Image? = nil, action: @escaping () -> Void) {
        self.image = image
        self.action = action
    }
    
    ///  View body
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.ultraThinMaterial)
            
            Image(systemName: "person")
                .resizable()
                .padding(20)
                .clipShape(Circle())
            
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            }
        }
        .frame(width: 100, height: 100)
        .padding(8)
        .overlay(alignment: .bottomTrailing) {
            Button(action: action) {
                Image(systemName: "pencil")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color("pink_primary"))
                    .clipShape(Circle())
            }
        }
    }
}
