//
//  PickerInputComponent.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 05/09/2022.
//

import SwiftUI

struct PickerInputComponent<T: Description>: View {
    @State var label: String?
    @Binding var value: T
    @State var isRequired: Bool
    
    @Binding var showPicker: Bool
    @FocusState var isFocused
    
    init(label: String? = nil, value: Binding<T>, isRequired: Bool = false, showPicker: Binding<Bool>) {
        _label = State(initialValue: label)
        _value = value
        _isRequired = State(initialValue: isRequired)
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
                        .stroke(showPicker ? Color("pink_primary") : Color("black_primary"), lineWidth: 2)
                        .frame(height: 50)
                    HStack {
                        Text(value.description)
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

struct PickerInputComponentForInt: View {
    @State var label: String?
    @Binding var value: Int
    @State var isRequired: Bool
    
    @Binding var showPicker: Bool
    @FocusState var isFocused
    
    init(label: String? = nil, value: Binding<Int>, isRequired: Bool = false, showPicker: Binding<Bool>) {
        _label = State(initialValue: label)
        _value = value
        _isRequired = State(initialValue: isRequired)
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
                        .stroke(showPicker ? Color("pink_primary") : Color("black_primary"), lineWidth: 2)
                        .frame(height: 50)
                    HStack {
                        Text("\(value)")
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
