/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Authors:
 + S3877980 - Ho Le Minh Thach
 + S3878231 - Truong Nhat Anh
 + S3877698 - Nguyen Luu Quoc Bao
 + S3820098  - Le Nguyen Truong An
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgements: Learning from Hacking with Swift to implement MVVM, and the usage of CoreData
 Hudson, P. (n.d.). The 100 days of Swiftui. Hacking with Swift. Retrieved July 30, 2022, from https://www.hackingwithswift.com/100/swiftui
*/

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
    
    /// View body
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.background).background(Color("background"))
            
            VStack(alignment: .leading, spacing: 10) {
                if let label = label {
                    Text(label).modifier(LabelStyle(isRequired: isRequired))
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 25).stroke(showPicker ? Color("pink_primary") : Color("black_primary"), lineWidth: 2)
                        .frame(height: 50).background(Color("background"))
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
            }.background(Color("background"))
        }
        .onTapGesture {
            withAnimation {
                showPicker.toggle()
            }
        }
    }
}

/// Picker input component for int
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
    
    /// View body
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.background).background(Color("background"))
            
            VStack(alignment: .leading, spacing: 10) {
                if let label = label {
                    Text(label).modifier(LabelStyle(isRequired: isRequired))
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(showPicker ? Color("pink_primary") : Color("black_primary"), lineWidth: 2)
                        .frame(height: 50).background(Color("background"))
                    HStack {
                        Text("\(value)")
                            .modifier(InputStyle(isFocused: $isFocused))
                        Spacer()
                        Image(systemName: showPicker ? "chevron.compact.up" : "chevron.compact.down")
                            .foregroundColor(.gray)
                            .font(.body.bold())
                            .padding(.trailing, 20)
                    }
                }.background(Color("background"))
            }.background(Color("background"))
        }.onTapGesture {
            /// animation
            withAnimation {
                showPicker.toggle()
            }
        }
    }
}
