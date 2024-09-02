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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AssignmentView(assignment: AssignmentModel(
        assignmentId: "0000",
        title: "ASSIGNMENT TITLE",
        content: "CONTENT",
        submissionTypes: [],
        numSubmissions: 1
    ))
}
