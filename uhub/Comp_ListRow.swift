//
//  ListRow.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 09/09/2022.
//

import SwiftUI

struct ListRow: View {
    let icon: String
    let label: String
    var showNavigationIcon: Bool = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
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
        }.background(Color("background"))
    }
}
