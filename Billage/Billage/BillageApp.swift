//
//  BillageApp.swift
//  Billage
//
//  Created by 변상우 on 9/10/24.
//

import SwiftUI
import Firebase
import FirebaseMessaging

@main
struct BillageApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject var authStore = AuthStore()
    @ObservedObject var signUpUserStore = SignUpUserStore()
    @ObservedObject var reservationStore = ReservationStore()
    @ObservedObject private var navigationPathManager = NavigationPathManager()
    
    @StateObject private var overlayManager = OverlayManager()
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(authStore)
                .environmentObject(signUpUserStore)
                .environmentObject(reservationStore)
                .environmentObject(overlayManager)
                .environmentObject(navigationPathManager)
                .overlay(OverlayContainer().environmentObject(overlayManager))
        }
    }
}

// Configuring Firebase Push Notification...
// See my Full Push Notification Video...
// Link in Description...

class AppDelegate: NSObject, UIApplicationDelegate{
    
    let gcmMessageIDKey = "gcm.message_id"
    
    // 앱이 켜졌을 때
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 파이어베이스 설정
        FirebaseApp.configure()
        
        // Setting Up Notifications...
        // 원격 알림 등록
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOption,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        
        // Setting Up Cloud Messaging...
        // 메세징 델리겟
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    // fcm 토큰이 등록 되었을 때
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
}

// Cloud Messaging...
extension AppDelegate: MessagingDelegate{
    
    // fcm 등록 토큰을 받았을 때
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

        KeychainStore.sharedKeychain.saveFcmToken(fcmToken ?? "")
        
        // Store this token to firebase and retrieve when to send message to someone...
//        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        
        // Store token in Firestore For Sending Notifications From Server in Future...
        
//        print(dataDict)
     
    }
}

// User Notifications...[AKA InApp Notification...]

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  
    // 푸시 메세지가 앱이 켜져있을 때 나올떄
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
      
    let userInfo = notification.request.content.userInfo

    
    // Do Something With MSG Data...
    if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
    }
    
    
    print(userInfo)

    completionHandler([[.banner, .badge, .sound]])
  }

    // 푸시메세지를 받았을 떄
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    // Do Something With MSG Data...
    if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
    }
      
    print(userInfo)

    completionHandler()
  }
}
