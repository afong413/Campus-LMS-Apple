//
//  AssignmentView.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import SwiftUI

struct AssignmentView: View {
    let assignment: AssignmentModel
        
    var body: some View {
        AttributedText(.html(withBody: assignment.content))
            .padding(.horizontal)
            .navigationTitle(assignment.title)
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AssignmentView(assignment: AssignmentModel(
            assignmentId: "0000",
            title: "ASSIGNMENT TITLE",
            content: "CONTENT",
            submissionTypes: [],
            numSubmissions: 1
        ))
    }
}
