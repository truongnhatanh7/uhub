//
//  EditProfileViewModel.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 05/09/2022.
//

import Foundation
import UIKit
import SwiftUI

@MainActor class EditProfileViewModel: ObservableObject {
    @Published var fullname: String
    @Published var age: String
    @Published var email: String
    @Published var school: String
    @Published var major: String
    @Published var gpa: String
    @Published var semesterLearned: String
    @Published var about: String
    
    @Published var showImagePicker = false
    @Published var inputImage: UIImage? = nil
    @Published var image: Image?
    
    @Published var showAgePicker = false
    @Published var showGPAPicker = false
    @Published var showSemesterLearned = false
    
    let ageRange = (6...100).compactMap { "\($0)" }
    let GPARange = ["Less than 50%", "50% - 59%", "60% - 69%", "70% - 79%", "80% - 100%"]
    let semesterLearnedRange = (0...20).compactMap { "\($0)" }
    
    var isDisabled: Bool {
        image == nil || fullname.isEmpty || age.isEmpty || school.isEmpty || major.isEmpty || gpa.isEmpty || semesterLearned.isEmpty
    }
    
    init(fullname: String = "", age: String = "", email: String = "", school: String = "", major: String = "", gpa: String = "", semesterLearned: String = "", about: String = "") {
        self.fullname = fullname
        self.age = age
        self.email = email
        self.school = school
        self.major = major
        self.gpa = gpa
        self.semesterLearned = semesterLearned
        self.about = about
    }
    
    func updateField(_ field: Field, _ newValue: String) {
        let filtered = newValue.filter { $0.isNumber }
        if filtered != newValue {
            switch field {
            case .FullName:
                return
            case .Age:
                self.age = filtered
            case .Email:
                return
            case .School:
                return
            case .Major:
                return
            case .GPA:
                self.gpa = filtered
            case .SemeterLearned:
                self.semesterLearned = semesterLearned
            case .About:
                return
            }
        }
    }
    
    /// This function is to get the input image and add to the render view
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

enum Field: Int {
    case FullName, Age, Email, School, Major, GPA, SemeterLearned, About
}
