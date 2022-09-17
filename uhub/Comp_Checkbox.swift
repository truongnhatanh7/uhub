//
//  CheckboxView.swift
//  uhub
//
//  Created by Andrew Le Nguyen on 02/09/2022.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
    
    /// View body
    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(Color("pink_primary"))
            .onTapGesture {
                self.checked.toggle()
            }
    }
}
