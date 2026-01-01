//
//  UserAuthInfo 2.swift
//  HopChat
//
//  Created by Pranav on 01/01/26.
//


import FirebaseAuth

extension UserAuthInfo{
   
    // Firebase → Sendable mapping
    init(user: FirebaseUser) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}
