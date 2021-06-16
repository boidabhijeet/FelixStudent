//
//  DatabaseReference.swift
//  Felix Student
//
//  Created by Mac on 20/04/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class DatabaseReference {
    static let shared = DatabaseReference()
    let db = Firestore.firestore()
    let environment = Constants.PRODUCTION
    var topicArray: [Topic] = []
    
    private init() {
        
    }
    
    func batchReference() -> CollectionReference {
        return db.collection(environment).document(Constants.BATCHES).collection(Constants.BATCHES)
    }
    
    func attendanceReference() -> CollectionReference {
        return db.collection(environment).document(Constants.ATTENDANCE_INFO).collection(Constants.ATTENDANCE)
    }
    
    func topicReference() -> CollectionReference {
        return db.collection(environment).document(Constants.ATTENDANCE_INFO).collection(Constants.TOPICS)
    }
    
    func studentRefReference() -> CollectionReference {
        return db.collection(environment).document(Constants.REFERENCES).collection(Constants.STUDENT_REFERENCE)
    }
    
    func generalFeedbackReference() -> CollectionReference {
        return db.collection(environment).document(Constants.FEEDBACKS).collection(Constants.GENERAL_FEEDBACKS)
    }
    
    func UsersReference() -> CollectionReference {
        return db.collection(environment).document(Constants.USERS).collection(Constants.USERS)
    }
    
    func walkinReference() -> CollectionReference {
        return db.collection(environment).document(Constants.WALKINS).collection(Constants.WALKINS)
    }
    
    func notificationReference() -> CollectionReference {
        return db.collection(environment).document(Constants.NOTIFICATIONS).collection(Constants.NOTIFICATIONS)
    }
}
