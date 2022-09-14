//
//  Model_User.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 07/09/2022.
//

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
    var image: Image?
    
    init(id: String?, name: String?, age: Int?, school: String?, major: String?, gpa: Int?, semesterLearned: Int?, about: String?, image: Image?) {
        self.id = id ?? UUID().uuidString
        self.name = name ?? "N/A"
        self.age = age ?? 18
        self.school = school ?? "N/A"
        self.major = major ?? "N/A"
        self.gpa = gpa ?? 0
        self.semesterLearned = semesterLearned ?? 0
        self.about = about ?? "N/A"
        self.image = image
    }
    
    func getFormattedGpa() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 2

        return formatter.string(from: self.gpa as NSNumber) ?? "0"
    }
}
