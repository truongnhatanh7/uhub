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
import UIKit
import SwiftUI
import FirebaseStorage

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
        retrieveImage(userId: currentUserData["id"] as? String ?? "", callback: {})
    }
    
    
    /// <#Description#> This function used to submit data
    func submitData(_ manager: UserAuthManager, callback: @escaping () -> ()) {
        uploadImage(userId: manager.currentUserData["id"] as? String ?? UUID().uuidString, callback: {})
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
