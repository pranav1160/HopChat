//
//  SettingsView.swift
//  ChatterFly
//
//  Created by Pranav on 24/10/25.
//

import SwiftUI


struct SettingsView: View {
    
    @State private var isPremium:Bool = true
    @State private var isAnonymousUser:Bool = false
    @State private var showCreateAccountScreen:Bool = false
    @State private var showAlert:AnyAppAlert?
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appstate
    @Environment(\.authService) private var authService
    
    var body: some View {
        NavigationStack {
            List {
                accountSection
                purchaseSection
                applicationSection
            }
        }
        .onAppear{
            setAnonymousUserStatus()
        }
        .sheet(isPresented: $showCreateAccountScreen) {
            setAnonymousUserStatus()
        } content: {
            CreateAccountView()
                .presentationDetents([.medium])
        }
        .showCustomAlert(alert: $showAlert)

        
        
    }
    
    private func setAnonymousUserStatus(){
        isAnonymousUser = authService
            .getAuthenticatedUser()?.isAnonymous == true
    }
    
    private func onCreateAccountButtonPressed(){
        showCreateAccountScreen = true
    }
    
    private func onSignOutButtonPressed() {
        Task {
            do {
                try authService.signOut()
                await dismissScreen()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
        }
    }
    
    func onDeleteAccountPressed() {
        showAlert = AnyAppAlert(
            alertTitle: "Delete Account?",
            alertSubtitle: "This action is permanent and cannot be undone. Your data will be deleted from our server forever.",
            buttons: {
                AnyView(
                    Button("Delete", role: .destructive, action: {
                        onDeleteAccountConfirmed()
                    })
                )
            }
        )
        
    }
    
    private func onDeleteAccountConfirmed() {
        Task {
            do {
                try await authService.deleteAccount()
                await dismissScreen()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
        }
    }
    
    private func dismissScreen() async {
        dismiss()
        try? await Task.sleep(for: .seconds(1))
        appstate.updateViewState(showTabBarView: false)
    }
    
    private var applicationSection: some View{
        Section {
            HStack{
                Text("Version")
                Spacer(minLength: 0)
                Text("\(Utilities.appVersion ?? "")")
                    .foregroundStyle(.secondary)
            }
            .rowFormatClickable()
            .removeExtraListFormatting()
            
            HStack{
                Text("Build Number")
                Spacer(minLength: 0)
                Text("\(Utilities.buildNumber ?? "")")
                    .foregroundStyle(.secondary)
            }
            .rowFormatClickable()
            .removeExtraListFormatting()
            
            Text("Contact Us")
                .foregroundStyle(.blue)
                .anyButton {
                    
                }
        }header:{
            Text("Application")
        }footer: {
            Text("Created by Pranav \nLearn more at https://github.com/pranav1160")
            
        }
    }
    
    private var purchaseSection: some View{
        Section {
            HStack(spacing:8){
                Text("Account Status: \(isPremium ? "PREMIUM" : "FREE")" )
                Spacer(minLength: 0)
                if isPremium{
                    Text("MANAGE")
                        .badgeStyle()
                }
            }
            .disabled(!isPremium)
            .frame(height: 18)
            .rowFormatClickable()
            .anyButton(style: .highlight, action: {
                
            })
            .removeExtraListFormatting()
            
            
        }header:{
            Text("PURCHASES")
        }
    }
    
    private var accountSection: some View{
        Section {
            if isAnonymousUser{
                Text("Save & back-up account")
                    .rowFormatClickable()
                    .anyButton(style: .highlight, action: {
                        onCreateAccountButtonPressed()
                    })
                    .removeExtraListFormatting()
            } else {
                Text("Sign Out")
                    .rowFormatClickable()
                    .anyButton(style: .highlight, action: {
                        onSignOutButtonPressed()
                    })
                    .removeExtraListFormatting()
            }
                
            
            Text("Delete Account")
                .foregroundStyle(.red)
                .rowFormatClickable()
                .anyButton(style: .highlight, action: {
                    
                })
                .removeExtraListFormatting()
            
        }header:{
            Text("Account")
        }
    }
}

#Preview("No auth") {
    SettingsView()
        .environment(\.authService, MockAuthService(user: nil))
        .environment(AppState())
}

#Preview("Anonymous") {
    SettingsView()
        .environment(
            \.authService,
             MockAuthService(user: UserAuthInfo.mock(isAnonymous: true))
        )
        .environment(AppState())
}

#Preview("Not anonymous") {
    SettingsView()
        .environment(
            \.authService,
             MockAuthService(user: UserAuthInfo.mock(isAnonymous: false))
        )
        .environment(AppState())
}

fileprivate extension View{
    func rowFormatClickable() -> some View{
        self
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.vertical,15)
            .padding(.horizontal,16)
            .background(Color(uiColor: .systemBackground))
    }
}
