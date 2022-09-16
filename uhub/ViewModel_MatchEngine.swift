//
//  ViewModel_MatchEngine.swift
//  uhub
//
//  Created by Truong Nhat Anh on 15/09/2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class MatchEngine: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var matchesUsers : [User] = []
    @Published var currentUser: User?
    
    func createMatchPackage(user: User) {
        if let currentUser = Auth.auth().currentUser {
            db.collection("matches").document(currentUser.uid).updateData([
                "users": FieldValue.arrayUnion([
                    [
                        "id": user.id,
                        "fullname": user.name,
                        "age": user.age,
                        "school": user.school,
                        "major": user.major,
                        "gpa": user.gpa,
                        "semester_learned": user.semesterLearned,
                        "about": user.about
                    ]
                ])
            ])
        }
    }
    
    func fetchAllMatches(callback: @escaping ()->()) {
        if let currentUser = Auth.auth().currentUser {
            db.collection("matches").document(currentUser.uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let matchesUsers = data?["users"] as? [[String: Any]] ?? [[:]]
                    print(matchesUsers)
                    self.matchesUsers = matchesUsers.map { element -> User in
                        let id = element["id"] as? String ?? ""
                        let fullname = element["fullname"] as? String ?? ""
                        let age = element["age"] as? Int ?? 0
                        let school = element["school"] as? String ?? ""
                        let major = element["major"] as? String ?? ""
                        let gpa = element["gpa"] as? Int ?? 0
                        let semester_learned = element["semester_learned"] as? Int ?? 0
                        let about = element["about"] as? String ?? ""
                        return User(id: id, name: fullname, age: age, school: school, major: major, gpa: gpa, semesterLearned: semester_learned, about: about)
                    }
                    callback()
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    func removeMatch(user: User) {
        if let currentUser = Auth.auth().currentUser {
            db.collection("matches").document(currentUser.uid).updateData([
                "users": FieldValue.arrayRemove([
                    [
                        "id": user.id,
                        "fullname": user.name,
                        "age": user.age,
                        "school": user.school,
                        "major": user.major,
                        "gpa": user.gpa,
                        "semester_learned": user.semesterLearned,
                        "about": user.about
                    ]
                ])
            ])
        }
    }
    
    func removeMatch(id: String) {

    }
}
