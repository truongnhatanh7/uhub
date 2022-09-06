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
    
    @Published var filterAge = ""
    @Published var filterGPA = ""
    @Published var filterSemester = ""
    
    let ageRange = ["Less than 6 years old", "6 - 10 years old", "11 - 15 years old", "16 - 18 years old", "19 - 26 years old", "26 - 35 years old", "36 - 45 years old", "46 - 55 years old", "Greater than 55 years old"]
    let GPARange = ["Less than 50%", "50% - 59%", "60% - 69%", "70% - 79%", "80% - 100%"]
    let semesterLearnedRange = ["Less than 4 semesters", "4 - 6 semesters", "7 - 9 semesters", "10 - 12 semesters", "Greater than 13 semesters"]
    
    
}
