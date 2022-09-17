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
    @Published var needReload: Bool = false
    @Published var showIsMatched: Bool = false
    
    private var fetchListnener: ListenerRegistration?
    
    deinit {
        fetchListnener?.remove()
    }
    
    func isMatchWithOtherPerson(_ user: User, whenMatched: @escaping ()->Void, whenNotMatched: @escaping ()->Void) {
        if let currentUser = Auth.auth().currentUser {
            db.collection("matches").document(user.id).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    var likeUsers = data?["users"] as? [[String: Any]] ?? [[:]]
                    
                    let targetIdx = likeUsers.firstIndex { element -> Bool in
                        element["id"] as? String ?? "" == currentUser.uid
                    }
                    
                    if let targetIdx = targetIdx {
                        likeUsers[targetIdx]["isMatched"] = true
                        self.db.collection("matches").document(user.id).setData([
                            "users": likeUsers
                        ])
                        whenMatched()
                    } else {
                        whenNotMatched()
                    }
                } else {
                    print("Document does not exist")
                    whenNotMatched()
                }
            }
        }
    }
    
    func createMatchPackage(_ user: User, isMatched: Bool) {
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
                        "about": user.about,
                        "isMatched": isMatched
                    ]
                ])
            ]) { err in
                if let err = err {
                    print(err)
                    self.db.collection("matches").document(currentUser.uid).setData([
                        "users": FieldValue.arrayUnion([
                            [
                                "id": user.id,
                                "fullname": user.name,
                                "age": user.age,
                                "school": user.school,
                                "major": user.major,
                                "gpa": user.gpa,
                                "semester_learned": user.semesterLearned,
                                "about": user.about,
                                "isMatched": isMatched
                            ]
                        ])
                    ])
                }
            }
        }
    }
    
    func fetchAllMatches(callback: @escaping ()->()) {
        if let currentUser = Auth.auth().currentUser {
            fetchListnener = db.collection("matches").document(currentUser.uid)
                .addSnapshotListener { (document, error) in
                withAnimation {
                    if let document = document, document.exists {
                        let data = document.data()
                        var matchesUsers = data?["users"] as? [[String: Any]] ?? [[:]]
                        matchesUsers = matchesUsers.filter { $0["isMatched"] as? Bool ?? false }
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
                        "about": user.about,
                        "isMatched": true
                    ]
                ])
            ]) { err in
                if let err = err {
                    print(err)
                }
            }
        }
    }
}
