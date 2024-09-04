//
//  AssignmentsHomeView.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import SwiftUI

struct AssignmentsHomeView: View {
    let course: CourseModel
    @StateObject var viewModel: RootViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.assignments) { assignment in
                NavigationLink(assignment.title) {
                    AssignmentView(assignment: assignment, course: course, viewModel: viewModel)
                }
            }
        }
        .onAppear {
            Task {
                try await viewModel.getAssignments(course: course)
            }
        }
        .navigationTitle("Assignments")
    }
}

#Preview {
    NavigationStack {
        AssignmentsHomeView(
            course: CourseModel(
                courseId: "0000",
                title: "Math 6",
                room: "Hill 22",
                teachers: [],
                students: []
            ),
            viewModel: RootViewModel()
        )
    }
}
