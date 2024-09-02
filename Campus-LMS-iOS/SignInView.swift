//
//  SignInView.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import SwiftUI

struct SignInView: View {
    /// Inherited from RootView.
    @StateObject var viewModel: RootViewModel
    
    var body: some View {
        VStack {
            Button("Sign In With Google") {
                Task {
                    try await viewModel.signInWithGoogle()
                }
            }
            .buttonStyle(.bordered)
            Spacer()
        }
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        SignInView(viewModel: RootViewModel())
    }
}
