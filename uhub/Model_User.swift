//
//  Model_User.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 07/09/2022.
//

import Foundation
import SwiftUI

struct User : Identifiable {
    var id = UUID()
    var name:String
    var gpa:CGFloat
    var major:String
    var about:String
    var courseStudying:[String]
    var image:String
    
    func getFormattedGpa() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 2

        return formatter.string(from: self.gpa as NSNumber) ?? "0"
        
    }
}
