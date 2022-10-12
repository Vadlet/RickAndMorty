//
//  LocalNotificationsService.swift
//  The Rick and Morty
//
//  Created by Vadlet on 02.10.2022.
//

import UserNotifications

protocol LocalRequestNotificationsProtocol: UNUserNotificationCenterDelegate {
    var notificationCenter: UNUserNotificationCenter { get }
    func requestAuthorization()
}

protocol LocalScheduleNotificationsProtocol: AnyObject {
    func scheduleNotifications(_ title: String)
}

final class LocalNotifications: NSObject, UNUserNotificationCenterDelegate, LocalRequestNotificationsProtocol, LocalScheduleNotificationsProtocol {
    var notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    private func getNotificationSettings() {
        notificationCenter.getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
        }
    }
    
    func scheduleNotifications(_ title: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Notification"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "notification",
                                            content: content,
                                            trigger: trigger)
        notificationCenter.add(request) { error in
            print(error?.localizedDescription ?? "No error")
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
       
        if response.notification.request.identifier == "notification" {
            print("Принт")
        }
        
        completionHandler()
    }
}
