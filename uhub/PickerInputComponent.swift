//
//  PickerInputComponent.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 05/09/2022.
//

import SwiftUI

struct PickerInputComponent: View {
    @State var label: String?
    @Binding var value: String
    @State var isRequired: Bool
    let items: [String]
    
    @Binding var showPicker: Bool
    @FocusState var isFocused
    
    init(label: String? = nil, value: Binding<String>, isRequired: Bool = false, items: [String] = [String](), showPicker: Binding<Bool>) {
        _label = State(initialValue: label)
        _value = value
        _isRequired = State(initialValue: isRequired)
        self.items = items
        _showPicker = showPicker
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.background)
            
            VStack(alignment: .leading, spacing: 10) {
                if let label = label {
                    Text(label).modifier(LabelStyle(isRequired: isRequired))
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(showPicker ? Color("pink_primary") : Color.gray.opacity(0.4), lineWidth: 2)
                        .frame(height: 50)
                    HStack {
                        Text(value)
                            .modifier(InputStyle(isFocused: $isFocused))
                        Spacer()
                        Image(systemName: showPicker ? "chevron.compact.up" : "chevron.compact.down")
                            .foregroundColor(.gray)
                            .font(.body.bold())
                            .padding(.trailing, 20)
                    }
                }
            }
        }
        .onTapGesture {
            withAnimation {
                showPicker.toggle()
            }
        }
    }
}
