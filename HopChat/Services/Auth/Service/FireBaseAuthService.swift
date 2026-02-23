//
//  FireBaseAuthService.swift
//  HopChat
//
//  Created by Pranav on 31/12/25.
//

import FirebaseAuth
import SwiftUI



struct FireBaseAuthService:AuthService{
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
    
    func signInWithGoogle() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let helper = GoogleSignInHelper()
        let tokens = try await helper.signIn()
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: tokens.idToken,
            accessToken: tokens.accessToken
        )
        
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
