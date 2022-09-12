//
//  ViewModel_Home.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 09/09/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var fetchedUsers: [User] = []
    @Published var displayingUsers: [User]? = nil
    
    func fetchData() {
        
    }
    
    func getIdx(user: User) -> Int {
        displayingUsers?.firstIndex { $0.id == user.id } ?? 0
    }
}
