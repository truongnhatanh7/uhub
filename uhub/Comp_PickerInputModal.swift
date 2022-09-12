//
//  PickerInputModal.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 05/09/2022.
//

import SwiftUI

struct PickerInputModal<T: Description & PickerEnum>: View {
    let label: String
    @Binding var showPicker: Bool
    @Binding var value: T
    
    var body: some View {
        OneThirdModal(label: label, showModal: $showPicker) {
            Picker("", selection: $value) {
                ForEach(T.allCases, id: \.self) {
                    Text($0.description)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

struct PickerInputModalInt: View {
    let label: String
    @Binding var showPicker: Bool
    @Binding var value: Int
    let items: [Int]
    
    var body: some View {
        OneThirdModal(label: label, showModal: $showPicker) {
            Picker("", selection: $value) {
                ForEach(items, id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(.wheel)
        }
    }
}
