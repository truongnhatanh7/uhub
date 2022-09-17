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

struct Card: View {
    @EnvironmentObject var imageManager: ImageManager
    let width: CGFloat
    let height: CGFloat
    let imageURL: String?
    @State var image: Image? = nil
    
    /// View body
    var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(LinearGradient(colors: [.clear, .clear, Color("pink_primary")], startPoint: .top, endPoint: .bottom))
                    )
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.gray)
                    .frame(width: width, height: height)
                    .cornerRadius(15)
                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(.circular)
                    .tint(Color("pink_primary"))
            }
        }
        .onAppear {
            imageManager.fetchFromUserId(id: imageURL ?? "") { img in
                if imageURL ==  "" {
                    image = Image("placeholder_avatar") // Change this to default image
                } else {
                    image = Image(uiImage: img)
                }

            }
        }
    }
}
