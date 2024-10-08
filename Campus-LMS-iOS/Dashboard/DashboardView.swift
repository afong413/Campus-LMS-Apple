//
//  DashboardView.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: RootViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.courses) { course in
                NavigationLink {
                    CourseView(course: course, viewModel: viewModel)
                } label: {
                    CourseCoverView(course: course)
                }
            }
        }
        .navigationTitle("Courses")
    }
}

#Preview {
    NavigationStack {
        DashboardView(viewModel: RootViewModel())
    }
}
