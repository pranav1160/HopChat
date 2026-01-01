//
//  CreateAccountView.swift
//  ChatterFly
//
//  Created by Pranav on 02/12/25.
//

import SwiftUI
import AuthenticationServices

struct CreateAccountView: View {
    @Environment(\.authService) private var authService
    @Environment(\.dismiss) private var dismiss
    var title:String = "Create Account?"
    var subtitle:String = "Don't lose your data.Connect to an SSO provider to save your account"
    
    var onDidSignIn:((_ isNewUser:Bool) -> Void)?
    
    var body: some View {
        VStack(spacing:40){
            VStack(alignment: .leading, spacing : 8){
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text(subtitle)
                    .font(.body)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
    
            SignInWithAppleButtonView(
                type: .signIn,
                style: .black,
                cornerRadius: 10)
            .frame(height: 55)
            .anyButton(style: .pressable) {
                onSignInWithApplePressed()
            }
            
            Spacer()
            
        }
        .padding()
        .padding(.top,40)
    }
    
    private func onSignInWithApplePressed(){
        Task{
            do {
                let result = try await authService.signInApple()
                print("Signed in with apple SUCCESS")
                onDidSignIn?(result.isNewUser)
                dismiss()
            } catch  {
                print("ERROR Signed in with apple")

            }
        }
    }
}

#Preview {
    CreateAccountView()
}
