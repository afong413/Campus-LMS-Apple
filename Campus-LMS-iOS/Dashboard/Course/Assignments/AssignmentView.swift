//
//  AssignmentView.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import SwiftUI
import FirebaseStorage

struct AssignmentView: View {
    let assignment: AssignmentModel
    let course: CourseModel
    @StateObject var viewModel: RootViewModel
    
    @State private var importing = false
    
    var body: some View {
        VStack {
            HTMLView(assignment.content)
            Button("Import") {
                importing = true
            }
            .fileImporter(
                isPresented: $importing,
                allowedContentTypes: [.text]
            ) { result in
                switch result {
                case .success(let file):
                    let access = file.startAccessingSecurityScopedResource()
                    
                    if !access { return }
                    
                    var data: Data? = nil
                    
                    do {
                        data = try Data(contentsOf: file)
                    } catch {
                        return
                    }
                    
                    Task {
                        guard let email = viewModel.user?.email else {
                            throw AuthError.unauthenticated
                        }
                        
                        let metadata = StorageMetadata()
                        metadata.contentType = file.mimeType()
                        
                        try await StorageManager.shared.submit(
                            course: course,
                            assignment: assignment,
                            email: email,
                            name: file.lastPathComponent,
                            data: data!,
                            metadata: metadata
                        )
                        
                        file.stopAccessingSecurityScopedResource()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        .navigationTitle(assignment.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AssignmentView(
            assignment: AssignmentModel(
                assignmentId: "0000",
                title: "ASSIGNMENT TITLE",
                content: "CONTENT",
                submissionTypes: [],
                numSubmissions: 1
            ),
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
