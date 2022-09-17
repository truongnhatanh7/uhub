//
//  PickerInputModal.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 05/09/2022.
//

import SwiftUI

/// Picker input modal
struct PickerInputModal<T: Description & PickerEnum>: View {
    let label: String
    @Binding var showPicker: Bool
    @Binding var value: T
    
    /// View body
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


/// Picker input modal int
struct PickerInputModalInt: View {
    let label: String
    @Binding var showPicker: Bool
    @Binding var value: Int
    let items: [Int]
    
    /// View body
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
