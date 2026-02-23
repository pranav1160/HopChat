//
//  ChatterFlyApp.swift
//  ChatterFly
//
//  Created by Pranav on 12/10/25.
//

import SwiftUI
import Firebase

@main
struct HopChatApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.authService, FireBaseAuthService())
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
