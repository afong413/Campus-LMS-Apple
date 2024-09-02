//
//  AuthManager.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import Foundation
import FirebaseAuth

struct AuthResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        uid = user.uid
        email = user.email
        photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    func signIn(credential: AuthCredential) async throws -> AuthResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        
        return AuthResultModel(user: authDataResult.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthResultModel {
        let credential = GoogleAuthProvider.credential(
            withIDToken: tokens.idToken,
            accessToken: tokens.accessToken
        )
        
        return try await signIn(credential: credential)
    }
    
    func getAuthenticatedUser() throws -> AuthResultModel {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.unauthenticated
        }
        
        return AuthResultModel(user: user)
    }
}

enum AuthError: Error {
    case unexpected
    
    case cannotFindTopVC
    case noClientId
    case noIdToken
    case unauthenticated
}
