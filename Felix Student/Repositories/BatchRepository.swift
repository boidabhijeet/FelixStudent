//
//  BatchRepository.swift
//  Felix Student
//
//  Created by Mac on 20/04/21.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import Resolver
import ObjectMapper

class BatchRepository: ObservableObject {
    let db = Firestore.firestore()
    @Published var batches = [Batch]()
    
    init() {
        loadBatchesForFaculty()
    }
    
    func loadBatchesForFaculty() {
        DatabaseReference.shared.batchReference().whereField("facultyUid", isEqualTo: "TfiyCnfHrzNRHjGnG6oOMTMga6M2").getDocuments { (snapshot, error) in
            if error == nil {
                self.batches.removeAll()
                for document in snapshot!.documents {
                    let batch = Mapper<Batch>().map(JSON: document.data())
                    self.batches.append(batch!)
                }
            } else {
                print("Something went wrong")
            }
        }
    }
    
    func loadBatchesForStudent(batchId: String) {
        DatabaseReference.shared.batchReference().whereField("batchId", isEqualTo: batchId).getDocuments { [unowned self] (snapshot, error) in
            if error == nil {
                for document in snapshot!.documents {
                    let batch = Mapper<Batch>().map(JSON: document.data())
                    self.batches.append(batch!)
                }
            }
        }
    }
}
