//
//  SettingsView.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import SwiftUI

struct SettingsView: View {
    /// Inherits from RootView
    @StateObject var viewModel: RootViewModel
    
    var body: some View {
        VStack {
            Button("Sign Out") {
                Task {
                    try viewModel.signOut()
                }
            }
            .buttonStyle(.bordered)
            Spacer()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(viewModel: RootViewModel())
    }
}
