//
//  PickerInputModal.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 05/09/2022.
//

import SwiftUI

struct PickerInputModal: View {
    let label: String
    @Binding var showPicker: Bool
    @Binding var value: String
    let items: [String]
    
    var body: some View {
        OneThirdModal(label: label, showModal: $showPicker) {
            Picker("", selection: $value) {
                ForEach(items, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}
