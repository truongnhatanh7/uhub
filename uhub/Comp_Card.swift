//
//  Card.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 13/09/2022.
//

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
