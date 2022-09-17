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

struct ButtonView: View {
    @State var textContent: String
    var isDisabled: Bool = false
    var isSecondaryBtn: Bool = false
    @State var onTap: () -> ()

    /// View body
    var body: some View {
        if isDisabled {
            Button(action: {
                // action
                onTap()
            }, label:  {
                Text("\(textContent)").bold()
            })
            .buttonStyle(DisabledButtonStyle(isSecondaryBtn: isSecondaryBtn))
            .disabled(true)
        } else {
            Button(action: {
                // action
                onTap()
            }, label:  {
                Text("\(textContent)").bold()
            })
            .buttonStyle(PrimaryButtonStyle(isSecondaryBtn: isSecondaryBtn))
            .disabled(false)
        }
    }
}

/// Primary Button Style
struct PrimaryButtonStyle: ButtonStyle {
    var isSecondaryBtn: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(isSecondaryBtn ? Color("pink_primary") : .white)
            Spacer()
        }
        .padding()
        .background(
            isSecondaryBtn ? .clear :
            configuration.isPressed ?
            Color("pink_disabled")
            : Color("pink_primary")
        )
        .cornerRadius(30)
        .overlay(RoundedRectangle(cornerRadius: 30).stroke(isSecondaryBtn ? Color("pink_primary") : .clear, lineWidth: 4))
        .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

/// Disable Button Style
struct DisabledButtonStyle: ButtonStyle {
    var isSecondaryBtn: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(.white)
            Spacer()
        }
        .padding()
        .background(Color("pink_disabled"))
        .cornerRadius(30)
    }
}
