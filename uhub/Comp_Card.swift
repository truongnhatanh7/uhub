//
//  Card.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 13/09/2022.
//

import SwiftUI

struct Card: View {
    let image: Image?
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        image?
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15)                    .foregroundStyle(LinearGradient(colors: [.clear, .clear, Color("pink_primary")], startPoint: .top, endPoint: .bottom)))
    }
}
