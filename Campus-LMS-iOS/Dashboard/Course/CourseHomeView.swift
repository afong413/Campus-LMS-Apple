//
//  CourseHomeView.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import SwiftUI

struct CourseHomeView: View {
    let course: CourseModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationTitle(course.title)
    }
}

#Preview {
    NavigationStack {
        CourseHomeView(course: CourseModel(
            courseId: "1234",
            title: "Math 6",
            room: "Hill 22",
            teachers: [],
            students: []
        ))
    }
}
