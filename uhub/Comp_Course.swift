//
//  Comp_Course.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 07/09/2022.
//

import SwiftUI

struct Comp_Course: View {
    
    var name:String
    
    /// View body
    var body: some View {
        Button(action: {}, label: {
            Text(name).modifier(CourseText())
        }).modifier(CourseButton())
    }
}
