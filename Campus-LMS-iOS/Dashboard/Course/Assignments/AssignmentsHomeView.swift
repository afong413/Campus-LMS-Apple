//
//  AssignmentsHomeView.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import SwiftUI

struct AssignmentsHomeView: View {
    @StateObject var viewModel: CourseViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.assignments) { assignment in
                NavigationLink(assignment.title) {
                    AssignmentView(assignment: assignment)
                }
            }
        }
        .onAppear {
            Task {
                try await viewModel.getAssignments()
            }
        }
        .navigationTitle("Assignments")
    }
}

#Preview {
    NavigationStack {
        AssignmentsHomeView(viewModel: CourseViewModel(course: CourseModel(
            courseId: "0000",
            title: "Math 6",
            room: "Hill 22",
            teachers: [],
            students: []
        )))
    }
}
