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
    @Published var fullname: String = ""
    @Published var age: Int = 18
    @Published var school: String = ""
    @Published var major: String = ""
    @Published var gpa: GPARange = .From50To59
    @Published var semesterLearned: Int = 0
    @Published var about: String = ""
    
    @Published var showImagePicker = false
    @Published var inputImage: UIImage? = nil
    @Published var image: Image?
    
    @Published var showAgePicker = false
    @Published var showGPAPicker = false
    @Published var showSemesterLearned = false
    
    let ageRange = (18...100).map { $0 }
//    let GPARange = ["Less than 50%", "50% - 59%", "60% - 69%", "70% - 79%", "80% - 100%"]
    let semesterLearnedRange = (0...20).map { $0 }
    
    var isDisabled: Bool {
        image == nil || fullname.isEmpty || school.isEmpty || major.isEmpty
    }
    
    func updateInfo(_ currentUserData: [String: Any]) {
        self.fullname = currentUserData["fullname"] as? String ?? ""
        self.age = currentUserData["age"] as? Int ?? 18
        self.school = currentUserData["school"] as? String ?? ""
        self.major = currentUserData["major"] as? String ?? ""
        self.gpa = GPARange(type: currentUserData["gpa"] as? Int ?? 0)
        self.semesterLearned = currentUserData["semester_learned"] as? Int ?? 0
        self.about = currentUserData["about"] as? String ?? ""
    }
    
    func submitData(_ manager: UserAuthManager, callback: @escaping () -> ()) {
        manager.updateProfileInfo(updatedData: [
            "fullname": fullname,
            "age": age,
            "school": school,
            "major": major,
            "gpa": gpa.rawValue,
            "semester_learned": semesterLearned,
            "about": about
        ], callback: callback)
    }
    
    /// This function is to get the input image and add to the render view
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

enum Field: Int {
    case FullName, Age, School, Major, GPA, SemeterLearned, About
}
