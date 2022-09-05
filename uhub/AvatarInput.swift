//
//  AvatarInput.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 05/09/2022.
//

import SwiftUI

struct AvatarInput: View {
    let image: Image?
    let action: () -> Void
    
    init(image: Image? = nil, action: @escaping () -> Void) {
        self.image = image
        self.action = action
    }
    
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

struct AvatarInput_Previews: PreviewProvider {
    static var previews: some View {
        AvatarInput(action: {})
        AvatarInput(image: Image("user"), action: {})
    }
}
