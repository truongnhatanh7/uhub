//
//  EditProfileViewModel.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 05/09/2022.
//

import Foundation
import UIKit
import SwiftUI
import FirebaseStorage

@MainActor class EditProfileViewModel: ObservableObject {
    @Published var fullname: String
    @Published var age: String
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
    
    let ageRange = (18...100).compactMap { "\($0)" }
    let GPARange = ["Less than 50%", "50% - 59%", "60% - 69%", "70% - 79%", "80% - 100%"]
    let semesterLearnedRange = (0...20).compactMap { "\($0)" }
    
    var isDisabled: Bool {
        image == nil || fullname.isEmpty || age.isEmpty || school.isEmpty || major.isEmpty || gpa.isEmpty || semesterLearned.isEmpty
    }
    
    func updateInfo(_ currentUserData: [String: Any]) {
        self.fullname = currentUserData["fullname"] as? String ?? ""
        self.age = currentUserData["age"] as? String ?? ageRange.first!
        self.age = self.age.isEmpty ? ageRange.first! : self.age
        self.school = currentUserData["school"] as? String ?? ""
        self.major = currentUserData["major"] as? String ?? ""
        self.gpa = currentUserData["gpa"] as? String ?? GPARange.first!
        self.gpa = self.gpa.isEmpty ? GPARange.first! : self.gpa
        self.semesterLearned = currentUserData["semester_learned"] as? String ?? semesterLearnedRange.first!
        self.semesterLearned = self.semesterLearned.isEmpty ? semesterLearnedRange.first! : self.semesterLearned
        self.about = currentUserData["about"] as? String ?? ""
    }
    
    init(fullname: String = "", age: String = "18", school: String = "", major: String = "", gpa: String = "Less than 50%", semesterLearned: String = "0", about: String = "") {
        self.fullname = fullname
        self.age = age
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
        self.image = Image(uiImage: inputImage)
    }
    
    /// This function is to reetrive user existing profile image from Storage database
    func retrieveImage(userId: String, callback: @escaping () -> ()) {
        // create storage ref
        let storageRef = Storage.storage().reference()
        
        // specify the remote file path and name
        let remoteFileRef = storageRef.child("images/\(userId).jpg")
        
        // retrieve the data
        remoteFileRef.getData(maxSize: 5*1024*1024) { data, error in
            // check for errors
            if error != nil && data == nil {
                print("[FAILURE - Retrieve Image]: \(error!.localizedDescription)")
            } else {
                if let transformImage = UIImage(data: data!) {
                    self.image = Image(uiImage: transformImage)
                    print("[SUCCESS - Retrieve Image]: User with ID = \(userId) - Profile image retrieved")
                    callback()
                } else {
                    print("[FAILURE - Retrieve Image]: Cannot transform image data")
                }
            }
        }
    }
    
    /// This function is to get the input image and upload it to Storage database
    func uploadImage(userId: String, callback: @escaping () -> ()) {
        // make sure that the selected image is not nil
        guard let inputImage = inputImage else { return }
        
        // create storage ref
        let storageRef = Storage.storage().reference()
        
        // turn selected image into data
        let imageData = inputImage.jpegData(compressionQuality: 0.8)
        
        // check that we were able to convert it to data
        guard imageData != nil else { return }
        
        // specify the remote file path and name
        let remoteFileRef = storageRef.child("images/\(userId).jpg")
        
        // upload data process starts
        remoteFileRef.putData(imageData!, metadata: nil) { metadata, error in
            // check for errors, great place to upload to Firestore if needed
            if error != nil && metadata == nil {
                print("[FAILURE - Upload Image]: \(error!.localizedDescription)")
            } else {
                print("[SUCCESS - Upload Image]: User with ID = \(userId) - Profile image uploaded")
                callback()
            }
        }
    }
}

enum Field: Int {
    case FullName, Age, School, Major, GPA, SemeterLearned, About
}
