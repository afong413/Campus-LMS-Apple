//
//  CourseView.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import SwiftUI

@MainActor
final class CourseViewModel: ObservableObject {
    let course: CourseModel
        
    init(course: CourseModel) {
        self.course = course
    }
    
    @Published var assignments: [AssignmentModel] = []
    
    func getAssignments() async throws {
        guard let courseId = course.courseId else {
            throw FirestoreError.noId
        }
        
        assignments = try await FirestoreManager.shared.getAssignments(courseId: courseId)
    }
}

struct CourseView: View {
    let course: CourseModel
    @StateObject var viewModel: RootViewModel
    
    var body: some View {
        List {
            NavigationLink("Assignments") {
                AssignmentsHomeView(course: course, viewModel: viewModel)
            }
        }
        .navigationTitle(course.title)
    }
}

#Preview {
    NavigationStack {
        CourseView(
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
