//
//  FireBaseAuthService.swift
//  HopChat
//
//  Created by Pranav on 31/12/25.
//

import FirebaseAuth
import SwiftUI



extension AuthDataResult {
    var asAuthInfo: (user: UserAuthInfo, isNewUser: Bool) {
        let isNewUser = additionalUserInfo?.isNewUser ?? false
        return (
            user: UserAuthInfo(user: user),
            isNewUser: isNewUser
        )
    }
}


extension EnvironmentValues{
    @Entry var authService : FireBaseAuthService = FireBaseAuthService()
}

struct FireBaseAuthService{
    func getAuthenticatedUser() -> UserAuthInfo? {
        if let user = Auth.auth().currentUser  {
            return UserAuthInfo(user: user)
        }
        return nil
    }
    
    func signInAnonymously() async throws -> (user : UserAuthInfo,isNewUser:Bool) {
        let result = try await Auth.auth().signInAnonymously()
        
        let isNewUser = result.additionalUserInfo?.isNewUser ?? true
        return (UserAuthInfo(user: result.user),isNewUser)
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let helper = SignInWithAppleHelper()
        let response = try await helper.signIn()
        
        let credential = OAuthProvider.credential(
            providerID: AuthProviderID.apple,
            idToken: response.token,
            rawNonce: response.nonce
        )
        
        if let user = Auth.auth().currentUser, user.isAnonymous {
            do {
                // Try to link to existing anonymous account
                let result = try await user.link(with: credential)
                return result.asAuthInfo
            } catch let error as NSError {
                let authError = AuthErrorCode(rawValue: error.code)
                switch authError {
                case .providerAlreadyLinked, .credentialAlreadyInUse:
                    if let secondaryCredential =
                        error.userInfo["FIRAuthErrorUserInfoUpdatedCredentialKey"] as? AuthCredential {
                        let result = try await Auth.auth().signIn(with: secondaryCredential)
                        return result.asAuthInfo
                    }
                default:
                    break
                }
            }
        }
        
        // Otherwise sign in to new account
        let result = try await Auth.auth().signIn(with: credential)
        return result.asAuthInfo
    }

    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        try await user.delete()
    }
    
    enum AuthError: LocalizedError {
        case userNotFound
        
        var errorDescription: String? {
            switch self {
            case .userNotFound:
                return "Current authenticated user not found."
            }
        }
    }

    
}
