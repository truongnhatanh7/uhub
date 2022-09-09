//
//  FilterProfileViewModel.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 06/09/2022.
//

import Foundation

@MainActor class FilterProfileViewModel: ObservableObject {
    @Published var showAgePicker = false
    @Published var showGPAPicker = false
    @Published var showSemesterLearned = false
    
    @Published var filterAge = "All"
    @Published var filterGPA = "All"
    @Published var filterSemester = "All"
    
    let ageRange = ["All", "18 - 27 years old", "28 - 37 years old", "38 - 47 years old", "48 - 57 years old", "Greater than 57 years old"]
    let GPARange = ["All", "Less than 50%", "50% - 59%", "60% - 69%", "70% - 79%", "80% - 100%"]
    let semesterLearnedRange = ["All", "Less than 4 semesters", "4 - 6 semesters", "7 - 9 semesters", "10 - 12 semesters", "Greater than 12 semesters"]
    
    func updateInfo(_ currentUserData: [String: Any]) {
        let tmpDict = currentUserData["friends_filter"] as? [String: Any]
        self.filterAge = tmpDict?["friends_age"] as? String ?? ageRange.first!
        self.filterAge = self.filterAge.isEmpty ? ageRange.first! : self.filterAge
        self.filterGPA = tmpDict?["freinds_gpa"] as? String ?? GPARange.first!
        self.filterGPA = self.filterGPA.isEmpty ? GPARange.first! : self.filterGPA
        self.filterSemester = tmpDict?["friends_semester_learned"] as? String ?? semesterLearnedRange.first!
        self.filterSemester = self.filterSemester.isEmpty ? semesterLearnedRange.first! : self.filterSemester
    }
}
