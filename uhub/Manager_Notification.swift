/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Authors:
 + S3877980 - Ho Le Minh Thach
 + S3878231 - Truong Nhat Anh
 + S3877698 - Nguyen Luu Quoc Bao
 + S3820098  - Le Nguyen Truong An
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgements: Learning from Hacking with Swift to implement MVVM, and the usage of CoreData
 Hudson, P. (n.d.). The 100 days of Swiftui. Hacking with Swift. Retrieved July 30, 2022, from https://www.hackingwithswift.com/100/swiftui
*/

import SwiftUI
import UserNotifications

class NotiManager: ObservableObject {
    func requestNotiAuth() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if error != nil {
                print("[FAILURE - Noti Manager]: \(error!.localizedDescription)")
            } else {
                print("[SUCCESS - Noti Manager]: Permission granted")
            }
        }
    }
    
    func generateNoti(title: String?, subtitle: String?) {
        let content = UNMutableNotificationContent()
        
        // textual content
        if let title = title {
            content.title = title
        }
        if let subtitle = subtitle {
            content.subtitle = subtitle
        }
        
        // trigger interval
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)
        
        // create request
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        // fire noti
        UNUserNotificationCenter.current().add(request)
    }
    
    func cleanNoti() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
