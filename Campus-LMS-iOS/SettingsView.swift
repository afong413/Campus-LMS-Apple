//
//  SettingsView.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel: RootViewModel
    
    var body: some View {
        List {
            Button("Sign Out") {
                Task {
                    try viewModel.signOut()
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(viewModel: RootViewModel())
    }
}
