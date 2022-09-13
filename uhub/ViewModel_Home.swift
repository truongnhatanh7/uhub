//
//  ViewModel_Home.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 09/09/2022.
//

import Foundation
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var fetchedUsers: [User] = []
    
    func fetchData(_ currentUserData: [String: Any]) {
        let usersRef = Firestore.firestore().collection("users")
        
        let filter = currentUserData["friends_filter"] as? [String: Any]
        var minAge: Int = 18
        var maxAge: Int = .max
        switch filter?["friends_age"] as? AgeRange ?? .All {
        case .All:
            minAge = 18
            maxAge = .max
        case .From18To27:
            minAge = 18
            maxAge = 27
        case .From28To37:
            minAge = 28
            maxAge = 37
        case .From38To47:
            minAge = 38
            maxAge = 47
        case .From48To57:
            minAge = 48
            maxAge = 57
        case .GreaterThan57:
            minAge = 58
        }
        usersRef
            .whereField("age", isGreaterThanOrEqualTo: minAge)
            .whereField("age", isLessThanOrEqualTo: maxAge)
            .getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let data = document.data()
                        let id = data["id"] as? String
                        let name = data["fullname"] as? String
                        let age = data["age"] as? Int
                        let school = data["school"] as? String
                        let major = data["major"] as? String
                        let gpa = data["gpa"] as? Int
                        let semesterLearned = data["semester_learned"] as? Int
                        let about = data["about"] as? String
                        let user = User(id: id, name: name, age: age, school: school, major: major, gpa: gpa, semesterLearned: semesterLearned, about: about)
                        self.fetchedUsers.append(user)
                    }
                }
            }
    }
    
    func getIdx(user: User) -> Int {
        fetchedUsers.firstIndex { $0.id == user.id } ?? 0
    }
}
