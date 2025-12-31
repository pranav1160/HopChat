//
//  FireBaseAuthService.swift
//  HopChat
//
//  Created by Pranav on 31/12/25.
//

import FirebaseAuth
import SwiftUI

extension EnvironmentValues{
    @Entry var authService : FireBaseAuthService = FireBaseAuthService()
}

struct UserAuthInfo: Sendable {
    let uid: String
    let email: String?
    let isAnonymous: Bool
    let creationDate: Date?
    let lastSignInDate: Date?
    
    init(
        uid: String,
        email: String? = nil,
        isAnonymous: Bool = false,
        creationDate: Date? = nil,
        lastSignInDate: Date? = nil
    ) {
        self.uid = uid
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.lastSignInDate = lastSignInDate
    }
    
    // Firebase → Sendable mapping
    init(user: FirebaseUser) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
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
        // if we dont get isNewUser we gonna assume its new
        let isNewUser = result.additionalUserInfo?.isNewUser ?? true
        return (UserAuthInfo(user: result.user),isNewUser)
    }
}
