//
//  uhubApp.swift
//  uhub
//
//  Created by Truong Nhat Anh on 30/08/2022.
//

import SwiftUI
import Firebase

@main
struct uhubApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            EditProfileView()
//                .environmentObject(PageViewModel())
//                .environmentObject(EditProfileViewModel())
//                .environmentObject(NotificationSettings(isVibarate: true, isShowChat: true, isShowNewMatch: true))
        }
    }
}
