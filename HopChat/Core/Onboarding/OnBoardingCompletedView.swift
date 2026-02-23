//
//  OnBoardingCompletedView.swift
//  ChatterFly
//
//  Created by Pranav on 24/10/25.
//

import SwiftUI

struct OnBoardingCompletedView: View {
    let profileColor:Color
    @Environment(AppState.self) private var appstate
    @State private var isProfileSetupFinishing:Bool = false
    var body: some View {
        VStack(alignment:.leading) {
            Text("Setup complete!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(profileColor)
            
            Text("We've set you profile and you're ready to start chatting.")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
        }
        .frame(maxHeight:.infinity)
        .padding(24)
        .safeAreaInset(edge: .bottom) {
            ctaButton
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func onFinishButtonPressed(){
        isProfileSetupFinishing = true
        Task{
            try await Task.sleep(for: .seconds(3))
            isProfileSetupFinishing = false
            appstate.updateViewState(showTabBarView: true)
        }
    }
    
    private var ctaButton: some View {
        AsyncCallToActionButton(
            isLoading: isProfileSetupFinishing,
            title: "Finish",
            action: onFinishButtonPressed
        )
    }
    
}

#Preview {
    NavigationStack {
        OnBoardingCompletedView(profileColor: .pink)
    }
    .environment(AppState(showTabBar: true))
}
