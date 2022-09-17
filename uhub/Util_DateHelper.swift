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

import Foundation

extension Date {
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: self)
    }
}

extension Formatter {
    static let specialFormat: DateFormatter = {
        let formatter = DateFormatter()

        // you can use a fixed language locale
        formatter.locale = Locale(identifier: "en")
        // or use the current locale
        // formatter.locale = .current
        
        // and for standalone local day of week use ccc instead of E
        formatter.dateFormat = "HH:mm dd/mm"
        return formatter
    }()
}
