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

@MainActor class FilterProfileViewModel: ObservableObject {
    @Published var showAgePicker = false
    @Published var showGPAPicker = false
    @Published var showSemesterLearned = false
    
    @Published var filterAge = AgeRange.All
    @Published var filterGPA = GPAFilterRange.All
    @Published var filterSemester = SemesterFilterRange.All
    
    
    /// This function used to update info
    /// - Parameter currentUserData: current data
    func updateInfo(_ currentUserData: [String: Any]) {
        let filter = currentUserData["friends_filter"] as? [String: Any]
        self.filterAge = AgeRange(type: filter?["friends_age"] as? Int ?? 0)
        self.filterGPA = GPAFilterRange(type: filter?["friends_gpa"] as? Int ?? 0)
        self.filterSemester = SemesterFilterRange(
            type: filter?["friends_semester_learned"] as? Int ?? 0
        )
    }
    
    
    /// Description This function used to submit data
    /// - Parameters:
    ///   - manager: manager
    ///   - callback: callback
    func submitData(_ manager: UserAuthManager, callback: @escaping () -> ()) {
        manager.updateProfileInfo(updatedData: [
            "friends_filter": [
                "friends_age": filterAge.rawValue,
                "friends_gpa": filterGPA.rawValue,
                "friends_semester_learned": filterSemester.rawValue
            ]
        ], callback: callback)
    }
}
