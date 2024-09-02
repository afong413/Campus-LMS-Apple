//
//  CourseCoverView.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import SwiftUI

struct CourseCoverView: View {
    let course: CourseModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.title)
                    .font(.title)
                    .bold()
                Text(course.room)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

#Preview {
    CourseCoverView(course: CourseModel(
        courseId: "1234",
        title: "Math 6",
        room: "Hill 22",
        teachers: [],
        students: []
    ))
}
