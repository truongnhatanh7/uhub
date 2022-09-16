//
//  DateHelper.swift
//  uhub
//
//  Created by Truong Nhat Anh on 03/09/2022.
//

import Foundation

extension Date {
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: self)
    }
}

extension Formatter {
    static let specialFormat: DateFormatter = {
        let formatter = DateFormatter()

        // you can use a fixed language locale
        formatter.locale = Locale(identifier: "en")
        // or use the current locale
        // formatter.locale = .current
        
        // and for standalone local day of week use ccc instead of E
        formatter.dateFormat = "HH:mm dd/mm"
        return formatter
    }()
}
