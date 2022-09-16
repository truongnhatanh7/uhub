//
//  Util_Filter.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 16/09/2022.
//

import Foundation

enum AgeRange: Int, CaseIterable, Description, PickerEnum {
    var description: String {
        switch self {
        case .All: return "All"
        case .From18To27: return "18 - 27 years old"
        case .From28To37: return "28 - 37 years old"
        case .From38To47: return "38 - 47 years old"
        case .From48To57: return "48 - 57 years old"
        case .GreaterThan57: return "Greater than 57 years old"
        }
    }
    
    init(type: Int) {
        switch type {
        case 0: self = .All
        case 1: self = .From18To27
        case 2: self = .From28To37
        case 3: self = .From38To47
        case 4: self = .From48To57
        case 5: self = .GreaterThan57
        default: self = .All
        }
    }
    
    case All = 0
    case From18To27 = 1
    case From28To37 = 2
    case From38To47 = 3
    case From48To57 = 4
    case GreaterThan57 = 5
}

enum GPAFilterRange: Int, CaseIterable, Description, PickerEnum {
    var description: String {
        switch self {
        case .All: return "All"
        case .LessThan50: return "Less than 50%"
        case .From50To59: return "50% - 59%"
        case .From60To69: return "60% - 69%"
        case .From70To79: return "70% - 79%"
        case .From80To100: return "80% - 100%"
        }
    }
    
    init(type: Int) {
        switch type {
        case 0: self = .All
        case 1: self = .LessThan50
        case 2: self = .From50To59
        case 3: self = .From60To69
        case 4: self = .From70To79
        case 5: self = .From80To100
        default: self = .All
        }
    }
    
    case All = 0
    case LessThan50 = 1
    case From50To59 = 2
    case From60To69 = 3
    case From70To79 = 4
    case From80To100 = 5
}

enum GPARange: Int, CaseIterable, Description, PickerEnum {
    var description: String {
        switch self {
        case .LessThan50: return "Less than 50%"
        case .From50To59: return "50% - 59%"
        case .From60To69: return "60% - 69%"
        case .From70To79: return "70% - 79%"
        case .From80To100: return "80% - 100%"
        }
    }
    
    init(type: Int) {
        switch type {
        case 1: self = .LessThan50
        case 2: self = .From50To59
        case 3: self = .From60To69
        case 4: self = .From70To79
        case 5: self = .From80To100
        default: self = .LessThan50
        }
    }
    
    case LessThan50 = 1
    case From50To59 = 2
    case From60To69 = 3
    case From70To79 = 4
    case From80To100 = 5
}

enum SemesterFilterRange: Int, CaseIterable, Description, PickerEnum {
    var description: String {
        switch self {
        case .All: return "All"
        case .LessThan4: return  "Less than 4 semesters"
        case .From4To6: return "4 - 6 semesters"
        case .From7To9: return "7 - 9 semesters"
        case .From10To12: return "10 - 12 semesters"
        case .GreaterThan12: return "Greater than 12 semesters"
        }
    }
    
    init(type: Int) {
        switch type {
        case 0: self = .All
        case 1: self = .LessThan4
        case 2: self = .From4To6
        case 3: self = .From7To9
        case 4: self = .From10To12
        case 5: self = .GreaterThan12
        default: self = .All
        }
    }
    
    case All = 0
    case LessThan4 = 1
    case From4To6 = 2
    case From7To9 = 3
    case From10To12 = 4
    case GreaterThan12 = 5
}


protocol PickerEnum: Hashable, CaseIterable where AllCases == Array<Self> {}

protocol Description {
    var description: String { get }
}
