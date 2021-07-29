//
//  BatchViewModel.swift
//  Felix Student
//
//  Created by Mac on 20/04/21.TfiyCnfHrzNRHjGnG6oOMTMga6M2
//

import Foundation
import Combine
import ObjectMapper
import FirebaseAuth
import Firebase

class BatchViewModel: ObservableObject, Identifiable {
    @Published var batchRepository = BatchRepository()
    @Published var batchCellViewModels: [BatchCellViewModel] = []
    @Published var batches: [Batch] = []
    @Published var topicVM = TopicViewModel()
    var batchId = ""
    var id: String = ""
    private var cancellables = Set<AnyCancellable>()
    static var subscribedTopics: [String] = []

    init() {
    }
    
    func subscribe(facultyUid: String) {
        DatabaseReference.shared.batchReference().whereField(Constants.FACULTYUID, isEqualTo: facultyUid).whereField(Constants.BATCHTYPE, isEqualTo: Constants.ONGOING).order(by: "createdAt", descending: true).getDocuments { (snapshot, error) in
            
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                self.batches = []
                let documents = snapshot!.documents
//                self.batches = (documents?.compactMap({ (docsnap) -> Batch in
//                    return Mapper<Batch>().map(JSON: docsnap.data())!
//                }))!
                
                for doc in documents {
                    let batch = Mapper<Batch>().map(JSON: doc.data())
                    let branchStr = batch!.batchId + "_faculty"
                    BatchViewModel.subscribedTopics.append(branchStr)
                    Messaging.messaging().subscribe(toTopic: branchStr) { error in
                      
                    }

                    self.topicVM.loadTopicsWith(batchId: batch!.batchId) { (topicArray, avgFeedback, hrsCovered) in
                        batch?.totalHours = hrsCovered
                        self.batches.append(batch!)
                    }
                }
            }
        }
    }
    
    func getBatchForStudent() {
        DatabaseReference.shared.walkinReference().whereField(Constants.UID, isEqualTo: SessionStore.shared.session?.uid ?? Auth.auth().currentUser?.uid).getDocuments { (snap, err) in
            if let e = err {
                print("Error getting documents: \(e)")
            } else {
                let doc = snap?.documents
                if doc?.count == 0 {
                    return
                }
                let docData = doc![0].data()
                let student = Mapper<Student>().map(JSON: docData)
                SessionStore.shared.student = student
                if let batchId = student?.batchId {
                    DatabaseReference.shared.batchReference().document(batchId).getDocument { [self] (snapshot, error) in
                        if let err = error {
                            print("Error getting documents: \(err)")
                        } else {
                            let documents = snapshot?.data()
                            let batch = Mapper<Batch>().map(JSON: documents!)
                            let brachStr = batch!.batchId + "_student"
                            BatchViewModel.subscribedTopics.append(brachStr)
                            Messaging.messaging().subscribe(toTopic: brachStr) { error in
                              
                            }
                            self.batches.append(batch!)
                        }
                    }
                }
            }
        }
    }
}



