//
//  FirestoreManager.swift
//  Campus-LMS-iOS
//
//  Created by Aiden Fong on 9/2/24.
//

import Foundation
import FirebaseFirestore

struct UserModel: Codable {
    @DocumentID var email: String?
    let firstName: String
    let lastName: String
    let isFaculty: Bool
    let isAdmin: Bool
    let profileUrl: String?
    let courses: [DocumentReference]
}

struct CourseModel: Codable, Identifiable {
    let id = UUID()
    @DocumentID var courseId: String?
    let title: String
    let room: String
    let teachers: [DocumentReference]
    let students: [DocumentReference]
}

struct AssignmentModel: Codable, Identifiable {
    let id = UUID()
    @DocumentID var assignmentId: String?
    let title: String
    let content: String
    let submissionTypes: [String]?
    let numSubmissions: Int?
}

struct SubmissionsModel: Codable {
    @DocumentID var userEmail: String?
    let submissions: [String:Date]
}

final class FirestoreManager {
    static let shared = FirestoreManager()
    private init() {}
    
    let firestore = Firestore.firestore()
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getUser(_ ref: DocumentReference) async throws -> UserModel {
        try await ref.getDocument(as: UserModel.self, decoder: decoder)
    }
    
    func getUser(email: String) async throws -> UserModel {
        let ref = firestore.collection("users").document(email)
        
        return try await getUser(ref)
    }
    
    func getCourse(_ ref: DocumentReference) async throws -> CourseModel {
        try await ref.getDocument(as: CourseModel.self, decoder: decoder)
    }
    
    func getCourse(id: String) async throws -> CourseModel {
        let ref = firestore.collection("courses").document(id)
        
        return try await getCourse(ref)
    }
    
    func getAssignments(_ courseRef: DocumentReference) async throws -> [AssignmentModel] {
        let ref = courseRef
            .collection("assignments")
        
        let snapshot = try await ref.getDocuments()
        
        var assignments: [AssignmentModel] = []
        
        for doc in snapshot.documents {
            assignments.append(try doc.data(as: AssignmentModel.self, decoder: decoder))
        }
        
        return assignments
    }
    
    func getAssignments(courseId: String) async throws -> [AssignmentModel] {
        let courseRef = firestore.collection("courses").document(courseId)
        
        return try await getAssignments(courseRef)
    }
    
    func submit(course: CourseModel, assignment: AssignmentModel, email: String, file: String) async throws {
        guard let courseId = course.courseId, let assignmentId = assignment.assignmentId else {
            throw FirestoreError.noId
        }
        
        let ref = firestore.collection("courses").document(courseId)
            .collection("assignments").document(assignmentId)
            .collection("submissions").document(email)
        
        let doc = try await ref.getDocument()
        
        if doc.exists {
            var submissions = try doc.data(as: SubmissionsModel.self, decoder: decoder).submissions
            submissions[file] = Date()
            
            try await ref.updateData([
                "submissions": submissions
            ])
        } else {
            try await ref.setData([
                "submissions": [file:Date()]
            ])
        }
    }
}

enum FirestoreError: Error {
    case unexpected
    
    case noSuchDocument
    case noId
}
