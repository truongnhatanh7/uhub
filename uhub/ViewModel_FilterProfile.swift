//
//  FilterProfileViewModel.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 06/09/2022.
//

import Foundation
import SwiftUI

@MainActor class FilterProfileViewModel: ObservableObject {
    @Published var showAgePicker = false
    @Published var showGPAPicker = false
    @Published var showSemesterLearned = false
    
    @Published var filterAge = AgeRange.All
    @Published var filterGPA = GPAFilterRange.All
    @Published var filterSemester = SemesterFilterRange.All
    
    func updateInfo(_ currentUserData: [String: Any]) {
        let filter = currentUserData["friends_filter"] as? [String: Any]
        self.filterAge = AgeRange(type: filter?["friends_age"] as? Int ?? 0)
        self.filterGPA = GPAFilterRange(type: filter?["friends_gpa"] as? Int ?? 0)
        self.filterSemester = SemesterFilterRange(
            type: filter?["friends_semester_learned"] as? Int ?? 0
        )
    }
    
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
