//
//  StudentRepository.swift
//  Felix Student
//
//  Created by Mac on 23/04/21.
//


import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import Resolver
import ObjectMapper

class StudentRepository: ObservableObject {
    let db = Firestore.firestore()
    @Published var students = [Student]()
    
    init() {
       
    }
    
   
}

