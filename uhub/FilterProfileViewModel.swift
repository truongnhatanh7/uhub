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
}
