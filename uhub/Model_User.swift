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
import SwiftUI
import FirebaseStorage

struct User : Identifiable {
    var id: String
    var name: String
    var age: Int
    var school: String
    var major: String
    var gpa: Int
    var semesterLearned: Int
    var about: String
    
    init(id: String?, name: String?, age: Int?, school: String?, major: String?, gpa: Int?, semesterLearned: Int?, about: String?) {
        self.id = id ?? UUID().uuidString
        self.name = name ?? "N/A"
        self.age = age ?? 18
        self.school = school ?? "N/A"
        self.major = major ?? "N/A"
        self.gpa = gpa ?? 0
        self.semesterLearned = semesterLearned ?? 0
        self.about = about ?? "N/A"
    }
    
    
    ///  This function get the formatted gpa
    /// - Returns: formatted gpa
    func getFormattedGpa() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: self.gpa as NSNumber) ?? "0"
    }
}
