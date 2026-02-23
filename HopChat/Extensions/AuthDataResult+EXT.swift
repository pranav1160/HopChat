//
//  AuthDataResult+EXT.swift
//  HopChat
//
//  Created by Pranav on 23/02/26.
//
import FirebaseAuth

import Foundation

extension AuthDataResult {
    var asAuthInfo: (user: UserAuthInfo, isNewUser: Bool) {
        let isNewUser = additionalUserInfo?.isNewUser ?? false
        return (
            user: UserAuthInfo(user: user),
            isNewUser: isNewUser
        )
    }
}
