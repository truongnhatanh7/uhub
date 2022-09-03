//
//  ErrorMsgView.swift
//  uhub
//
//  Created by Andrew Le Nguyen on 02/09/2022.
//

import SwiftUI

struct ErrorMsgView: View {
    @State var msg: String
    
    var body: some View {
        HStack {
            SideIcon(
                iconName: "info.circle.fill",
                iconColor: Color("red_danger")
            )
            
            Text("\(msg)")
                .font(.system(size: 14))
                .foregroundColor(Color("red_danger"))
            
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color("pink_disabled").opacity(0.25))
                .cornerRadius(30)
        )
    }
}

struct SideIcon: View {
    private var iconName: String
    private var iconColor: Color
    
    init(iconName: String, iconColor: Color) {
        self.iconName = iconName
        self.iconColor = iconColor
    }
    
    var body: some View {
        Image(systemName: iconName)
            .foregroundColor(iconColor)
    }
}

struct ErrorMsgView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMsgView(msg: "Invalid email")
    }
}

