//
//  HeaderHome.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 09/09/2022.
//

import SwiftUI

struct HeaderHome: View {
    let title: String
    
    /// View body
    var body: some View {
        HStack {
            Image("Icon")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            Text(title)
                .font(.title.bold())
                .foregroundStyle(.primary)
            Spacer()
        }
        .padding(.horizontal)
    }
}
