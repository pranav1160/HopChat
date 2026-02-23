//
//  User.swift
//  ChatterFly
//
//  Created by Pranav on 31/10/25.
//

import Foundation
import SwiftUI

struct User{
    let userId:String
    let dateCreated:Date?
    let didCreateOnboarding:Bool?
    let profileColorHex:String?
    
    var profileColorCalculated:Color{
        if let profileColorHex{
            return Color(hex: profileColorHex)
        } else {
            return Color.accentColor
        }
    }
    
    init(
        userId: String,
        dateCreated: Date? = nil,
        didCreateOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userId = userId
        self.dateCreated = dateCreated
        self.didCreateOnboarding = didCreateOnboarding
        self.profileColorHex = profileColorHex
    }
}


extension User {
    static let mock = User(
        userId: "user_001",
        dateCreated: Date(timeIntervalSinceNow: -86400 * 10), // 10 days ago
        didCreateOnboarding: true,
        profileColorHex: "#4ECDC4"
    )
    
    static let mock2 = User(
        userId: "user_002",
        dateCreated: Date(timeIntervalSinceNow: -86400 * 5), // 5 days ago
        didCreateOnboarding: false,
        profileColorHex: "#FF6B6B"
    )
    
    static let mock3 = User(
        userId: "user_003",
        dateCreated: Date(timeIntervalSinceNow: -86400 * 30), // 30 days ago
        didCreateOnboarding: true,
        profileColorHex: "#1A535C"
    )
    
    static let mock4 = User(
        userId: "user_004",
        dateCreated: Date(), // today
        didCreateOnboarding: nil,
        profileColorHex: "#FFE66D"
    )
    
    static let mocks: [User] = [mock, mock2, mock3, mock4]
}
