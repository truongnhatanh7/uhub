//
//  Card.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 13/09/2022.
//

import SwiftUI

struct Card: View {
    @State var image: Image?
    @EnvironmentObject var imageManager: ImageManager
    let width: CGFloat
    let height: CGFloat
    let imageURL: String?
    
    var body: some View {
        image?
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15)                    .foregroundStyle(LinearGradient(colors: [.clear, .clear, Color("pink_primary")], startPoint: .top, endPoint: .bottom)))
            .onAppear {
                imageManager.fetchFromUserId(id: imageURL ?? "") { img in
                    if imageURL ==  "" {
                        self.image = Image("User4") // Change this to default image
                    } else {
                        self.image = Image(uiImage: img)
                    }
                    
                }
            }
            
    }
}
