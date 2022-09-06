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
