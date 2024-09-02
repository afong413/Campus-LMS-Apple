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

final class FirestoreManager {
    static let shared = FirestoreManager()
    private init() {}
    
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
        return try await ref.getDocument(as: UserModel.self, decoder: decoder)
    }
    
    func getUser(email: String) async throws -> UserModel {
        let ref = Firestore.firestore()
            .collection("users")
            .document(email)
        
        return try await getUser(ref)
    }
    
    func getCourse(_ ref: DocumentReference) async throws -> CourseModel {
        return try await ref.getDocument(as: CourseModel.self, decoder: decoder)
    }
    
    func getCourse(id: String) async throws -> CourseModel {
        let ref = Firestore.firestore()
            .collection("courses")
            .document(id)
        
        return try await getCourse(ref)
    }
}

enum FirestoreError: Error {
    case unexpected
    
    case noSuchDocument
    case noId
}
