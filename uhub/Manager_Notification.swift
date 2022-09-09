//
//  Manager_Notification.swift
//  uhub
//
//  Created by Andrew Le Nguyen on 09/09/2022.
//

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
