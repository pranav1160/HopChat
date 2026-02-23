//
//  CreateAccountView.swift
//  ChatterFly
//
//  Created by Pranav on 02/12/25.
//

import SwiftUI

struct CreateAccountView: View {
    @Environment(\.authService) private var authService
    @Environment(\.dismiss) private var dismiss
    
    var title: String = "Create Account?"
    var subtitle: String = "Don't lose your data. Connect to Google to save your account"
    
    var onDidSignIn: ((_ isNewUser: Bool) -> Void)?
    
    var body: some View {
        VStack(spacing: 40) {
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text(subtitle)
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // ✅ Google Sign-In Button
            Button {
                onSignInWithGooglePressed()
            } label: {
                HStack(spacing: 12) {
                    Image(.googleLogo1) // add Google logo asset
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("Continue with Google")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3))
                )
            }
            
            Spacer()
        }
        .padding()
        .padding(.top, 40)
    }
    
    private func onSignInWithGooglePressed() {
        Task {
            do {
                let result = try await authService.signInWithGoogle()
                print("Signed in with Google SUCCESS")
                onDidSignIn?(result.isNewUser)
                dismiss()
            } catch {
                print("ERROR signing in with Google:", error)
            }
        }
    }
}

#Preview {
    CreateAccountView()
}
