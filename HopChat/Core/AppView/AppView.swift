//
//  AppView.swift
//  ChatterFly
//
//  Created by Pranav on 21/10/25.
//

import SwiftUI

struct AppView: View {
    @State private var appState = AppState()
    @Environment(\.authService) private var authService
    
    var body: some View {
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabBarView: {
                TabBarView()
            },
            onBoardingView: {
                WelcomeView()
            }
        )
        .environment(appState)
        .task {
            await checkUserStatus()
        }
        .onChange(of: appState.showTabBar) { _, showTabBar in
            if !showTabBar {
                Task {
                    await checkUserStatus()
                }
            }
        }

    }
    
    private func checkUserStatus() async {
        if let user = authService.getAuthenticatedUser(){
            print("User is already authenticated - \(user.uid)")
            //user is anonymously authenticated
        } else {
            //user is not anonymously authenticated
            
            do {
                let res = try await authService.signInAnonymously()
                print("sign in success - \(res.user.uid). New User - \(res.isNewUser)")
            } catch let err {
                print(err.localizedDescription)
            }
        }
    }
}

#Preview("AppView - TabBar") {
    AppView()
        .environment(AppState(showTabBar: true))
}

#Preview("AppView - OnBoarding") {
    AppView()
        .environment(AppState(showTabBar: false))
}
