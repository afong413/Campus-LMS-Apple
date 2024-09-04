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
    @Published var courses: [CourseModel] = []
    @Published var authenticated = true
    @Published var assignments: [AssignmentModel] = []
    
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
        courses = []
        authenticated = false
    }
    
    func getCourses() async throws {
        guard let email = user?.email else {
            throw AuthError.unauthenticated
        }

        let userModel = try await FirestoreManager.shared.getUser(email: email)

        courses = []
                
        for ref in userModel.courses {
            courses.append(try await FirestoreManager.shared.getCourse(ref))
        }
    }
    
    func getAssignments(course: CourseModel) async throws {
        guard let courseId = course.courseId else {
            throw FirestoreError.noId
        }
        
        assignments = try await FirestoreManager.shared.getAssignments(courseId: courseId)
    }
}

struct RootView: View {
    @StateObject var viewModel = RootViewModel()
    
    var body: some View {
        TabView {
            NavigationStack { DashboardView(viewModel: viewModel) }
                .tabItem { Label("Dashboard", systemImage: "house") }
            NavigationStack { SettingsView(viewModel: viewModel) }
                .tabItem { Label("Settings", systemImage: "gear") }
        }
        .fullScreenCover(isPresented: !$viewModel.authenticated) {
            NavigationStack {
                SignInView(viewModel: viewModel)
            }
        }
        .onAppear {
            Task {
                try viewModel.getAuthenticatedUser()
                try await viewModel.getCourses()
            }
        }
    }
}

#Preview {
    RootView()
}
