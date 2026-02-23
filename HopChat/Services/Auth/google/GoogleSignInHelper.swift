//
//  GoogleSignInTokens.swift
//  HopChat
//
//  Created by Pranav on 23/02/26.
//


import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

struct GoogleSignInTokens {
    let idToken: String
    let accessToken: String
}

final class GoogleSignInHelper {

    @MainActor
    func signIn() async throws -> GoogleSignInTokens {
        guard
            let clientID = FirebaseApp.app()?.options.clientID
        else {
            throw GoogleSignInError.missingClientID
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let rootViewController = Self.rootViewController else {
            throw GoogleSignInError.missingRootViewController
        }

        let result = try await GIDSignIn.sharedInstance.signIn(
            withPresenting: rootViewController
        )

        guard
            let idToken = result.user.idToken?.tokenString
        else {
            throw GoogleSignInError.missingIDToken
        }

        let accessToken = result.user.accessToken.tokenString

        return GoogleSignInTokens(
            idToken: idToken,
            accessToken: accessToken
        )
    }
}

// MARK: - Errors
enum GoogleSignInError: LocalizedError {
    case missingClientID
    case missingRootViewController
    case missingIDToken

    var errorDescription: String? {
        switch self {
        case .missingClientID:
            return "Firebase client ID not found."
        case .missingRootViewController:
            return "Unable to find root view controller."
        case .missingIDToken:
            return "Google ID token missing."
        }
    }
}

// MARK: - Root VC Finder
private extension GoogleSignInHelper {
    static var rootViewController: UIViewController? {
        UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first { $0.isKeyWindow }?
            .rootViewController
    }
}
