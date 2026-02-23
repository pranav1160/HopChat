//
//  AuthService.swift
//  HopChat
//
//  Created by Pranav on 23/02/26.
//
import Foundation
import SwiftUI

extension EnvironmentValues{
    @Entry var authService : AuthService = MockAuthService()
}

protocol AuthService {
    func getAuthenticatedUser() -> UserAuthInfo?
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signInWithGoogle() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signOut() throws
    func deleteAccount() async throws
}

struct MockAuthService: AuthService {
   

    let currentUser:UserAuthInfo?
    
    init(user: UserAuthInfo? = nil) {
        self.currentUser = user
    }
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        currentUser
    }

    func signInAnonymously() async throws -> (
        user: UserAuthInfo,
        isNewUser: Bool
    ) {
        let user = UserAuthInfo.mock(isAnonymous: true)
        return (user,true)
    }

    func signInWithGoogle() async throws -> (
        user: UserAuthInfo,
        isNewUser: Bool
    ) {
        let user = UserAuthInfo.mock(isAnonymous: false)
        return (user,false)
    }

    func signOut() throws {
        
    }
    
    func deleteAccount() async throws {
        
    }

   
}
