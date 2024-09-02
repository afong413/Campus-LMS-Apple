//
//  GoogleSignInHelper.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import Foundation
import GoogleSignIn
import FirebaseCore

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}

final class GoogleSignInHelper {
    static let shared = GoogleSignInHelper()
    private init() {}
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        guard let topViewController = Utilities.shared.topViewController() else {
            throw AuthError.cannotFindTopVC
        }

        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topViewController)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw AuthError.noIdToken
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        return GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
    }
}
