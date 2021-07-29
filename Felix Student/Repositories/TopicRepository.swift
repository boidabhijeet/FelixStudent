//
//  TopicRepository.swift
//  Felix Student
//
//  Created by Mac on 23/04/21.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import ObjectMapper

class TopicRepository: ObservableObject {
    let db = Firestore.firestore()
    @Published var topics = [Topic]()
    
    init() {
//       loadTopicsWith(batchId: "8b4dBH0N2Av3n8xEaZro")
    }
    
}
