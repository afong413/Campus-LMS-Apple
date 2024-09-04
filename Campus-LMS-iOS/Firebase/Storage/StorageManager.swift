//
//  StorageManager.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    private init() {}
    
    private let storage = Storage.storage()
    
    func submit(course: CourseModel, assignment: AssignmentModel, email: String, name: String, data: Data, metadata: StorageMetadata? = nil) async throws {
        guard let courseId = course.courseId, let assignmentId = assignment.assignmentId else {
            throw URLError(.badURL) // Fix
        }
        
        let file = "files/\(courseId)/\(email)/\(assignmentId)/\(name)"
        
        let ref = storage.reference().child(file)

        try await ref.putDataAsync(data, metadata: metadata)
        
        try await FirestoreManager.shared.submit(course: course, assignment: assignment, email: email, file: file)
    }
    
    func getSubmission(course: CourseModel, user: UserModel, name: String) throws -> URL {
        guard let courseId = course.courseId,
              let email = user.email else {
            throw AuthError.unauthenticated
        }
        
        let ref = storage.reference().child("files/\(courseId)/\(email)/\(name)")
        
        var downloadUrl: URL? = nil
        
        ref.downloadURL { url, error in
            guard let error = error else {
                return
            }
            
            downloadUrl = url
        }
        
        guard let downloadUrl = downloadUrl else {
            throw URLError(.badURL) // Fix
        }
        
        return downloadUrl
    }
}
