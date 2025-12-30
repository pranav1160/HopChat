//
//  WelcomeView.swift
//  ChatterFly
//
//  Created by Pranav on 23/10/25.
//

import SwiftUI

struct WelcomeView: View {
    @State private var imageName: String = Constants.randomImage
    @State private var showSignInScreen:Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                ImageLoaderView(url: imageName)
                    .ignoresSafeArea()
                
                title
                    .padding(.top, 24)
                
                ctaButtons
                    .padding()
                
                policyLinks
            }
           
        }
        .sheet(isPresented: $showSignInScreen) {
            CreateAccountView(
                title: "Sign In",
                subtitle: "Connect to an existing account"
            )
                .presentationDetents([.medium])
        }
    }
    
    private func onSignInButtonPressed(){
        showSignInScreen = true
    }
    
    private var title: some View {
        VStack(spacing: 8) {
            Text("HopChat 🦋")
                .font(.largeTitle)
                .bold()
            
            Text("made by @pranav_san")
                .font(.caption)
                .foregroundStyle(Color.gray)
        }
    }
    
    private var ctaButtons: some View {
        VStack {
            NavigationLink {
                OnBoardingIntroView()
            }label: {
                Text("Get Started")
                    .callToAction()
            }
            
            Text("Already have an account? Sign in.")
                .underline()
                .font(.subheadline)
                .padding(8)
                .clearTapBackGround()
                .onTapGesture {
                    onSignInButtonPressed()
                }
        }
    }
    
    private var policyLinks: some View {
        HStack {
            Link(
                destination: URL(
                    string: Constants.termsOfServiceURL
                )!
            ) {
                Text("Terms of Service")
            }
            
            Circle()
                .fill(.accent)
                .frame(width: 4, height: 4)
            
            Link(
                destination: URL(
                    string: Constants.privacyPolicyURL
                )!
            ) {
                Text("Privacy Policy")
            }
        }
    }
}

#Preview {
    NavigationStack{
        WelcomeView()
            .environment(AppState())
    }
}
