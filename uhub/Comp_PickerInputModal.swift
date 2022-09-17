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
