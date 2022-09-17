//
//  uhubApp.swift
//  uhub
//
//  Created by Truong Nhat Anh on 30/08/2022.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        // Show local notification in foreground
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}
// Conform to UNUserNotificationCenterDelegate to show local notification in foreground
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .list, .badge, .sound])
    }
}

@main
struct uhubApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
