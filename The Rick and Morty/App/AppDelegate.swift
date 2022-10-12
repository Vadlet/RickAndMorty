//
// AppDelegate.swift
// The Rick and Morty
//
// Created by Vadlet on 03.08.2022.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var startService: StartService?
    private let localNotifications: LocalRequestNotificationsProtocol = LocalNotifications()
    private let storageSaveService: StorageSaveProtocol = StorageService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        startService = StartService(window)
        FirebaseApp.configure()
        
        localNotifications.requestAuthorization()
        localNotifications.notificationCenter.delegate = localNotifications
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        storageSaveService.saveContext()
    }
}
