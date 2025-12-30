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
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appstate
    
    var body: some View {
        NavigationStack {
            List {
                accountSection
                purchaseSection
                applicationSection
            }
        }
        .sheet(isPresented: $showCreateAccountScreen) {
            CreateAccountView()
                .presentationDetents([.medium])
        }
        
    }
    
    private func onCreateAccountButtonPressed(){
        showCreateAccountScreen = true
    }
    
    private func onSignOutButtonPresses() {
        dismiss()
        Task {
            try await Task.sleep(for: .seconds(1))
            appstate.updateViewState(showTabBarView: false)
        }
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
                        onSignOutButtonPresses()
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

#Preview {
    SettingsView()
        .environment(AppState(showTabBar: true))
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
