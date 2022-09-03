//
//  EditProfileView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 03/09/2022.
//

import SwiftUI

struct EditProfileView: View {
    @State private var fullName = ""
    @State private var age = 0
    @State private var email = ""
    @State private var school = ""
    @State private var major = ""
    @State private var gpa = 0
    @State private var semesterLearned = 0
    @State private var about = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                TextInput(label: "Full Name", value: $fullName, placeholder: "Full Name", isRequired: true)
                TextInput(label: "Email", value: $email, placeholder: "Email", isRequired: true)
                TextInput(label: "School", value: $school, placeholder: "School Name", isRequired: true)
                TextInput(label: "Major", value: $major, placeholder: "Learning Major", isRequired: true)
                TextInput(label: "About", value: $about, placeholder: "Tell me about yourself", isRequired: true)
            }
            .padding()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
