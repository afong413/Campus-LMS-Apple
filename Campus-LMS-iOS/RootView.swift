//
//  RootView.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import SwiftUI

@MainActor
final class RootViewModel: ObservableObject {
    @Published var user: AuthResultModel? = nil
    @Published var authenticated = false
    
    func getAuthenticatedUser() throws {
        do {
            try user = AuthManager.shared.getAuthenticatedUser()
            authenticated = true
        } catch {
            user = nil
            authenticated = false
            throw AuthError.unauthenticated
        }
    }
    
    func signInWithGoogle() async throws  {
        let tokens = try await GoogleSignInHelper.shared.signIn()
        
        user = try await AuthManager.shared.signInWithGoogle(tokens: tokens)
        
        authenticated = true
    }
    
    func signOut() throws {
        try AuthManager.shared.signOut()
        
        user = nil
        authenticated = false
    }
}

struct RootView: View {
    @StateObject var viewModel = RootViewModel()
    
    var body: some View {
        TabView {
            NavigationStack { SettingsView(viewModel: viewModel) }
                .tabItem { Label("Settings", systemImage: "gear") }
        }
        .fullScreenCover(isPresented: !$viewModel.authenticated) {
            NavigationStack {
                SignInView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    RootView()
}
