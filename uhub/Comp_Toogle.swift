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

struct Toogle: View {
    
    var label:String
    @Binding var toogle:Bool
    var handler: (_ isOn:Bool) -> Void
    
    /// View body
    var body: some View {
        Toggle(isOn: $toogle, label: {
            Text(label.capitalized).fontWeight(.semibold).font(.system(size: 16))
        }).padding(.horizontal, 24).padding(.vertical, 16).toggleStyle(SwitchToggleStyle(tint: Color("Primary"))).onChange(of: toogle) { value in
            
            handler(value)
        }
    }
}
