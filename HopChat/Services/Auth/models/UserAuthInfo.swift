//
//  UserAuthInfo.swift
//  HopChat
//
//  Created by Pranav on 01/01/26.
//

import SwiftUI

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
    
    static func mock(isAnonymous:Bool = false) -> Self{
        UserAuthInfo(
            uid: "mock_iser1160",
            email: "pranav@123",
            isAnonymous: isAnonymous,
            creationDate: .now,
            lastSignInDate: .now
        )
    }
    
}
