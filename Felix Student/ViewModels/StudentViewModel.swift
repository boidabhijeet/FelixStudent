//
//  StudentViewModel.swift
//  Felix Student
//
//  Created by Mac on 20/04/21.
//

import Foundation
import Combine
import ObjectMapper

class StudentViewModel: ObservableObject, Identifiable {
    var id: String = ""
    private var cancellables = Set<AnyCancellable>()
//    @Published var student: Student
    @Published var students: [Student] = []
    init() {
        
    }
    
    func saveProfileOfFaculty(email: String, fullName: String, contact: String) {
        print(email, fullName, contact)
        let leadId = SessionStore.shared.user?.uid
        DatabaseReference.shared.walkinReference().document(leadId!).updateData(["email": email, "fullName": fullName, "contact": Int64(contact)!])
    }
    
    func saveProfile(email: String, fullName: String, contact: String) {
        print(email, fullName, contact)
        let leadId = SessionStore.shared.student?.leadId
        DatabaseReference.shared.walkinReference().document(leadId!).updateData(["email": email, "fullName": fullName, "contact": Int64(contact)!])
    }
    
    func getStudentsFom(batchId: String, completionHandler:@escaping (([Student]) -> Void)) {
        DatabaseReference.shared.batchReference().document(batchId).getDocument { (snapshot, error) in
            if error == nil {
                let batch = Mapper<Batch>().map(JSON: (snapshot?.data())!)
                let students = batch?.students
                var studArray: [Student] = []
                for stud in students! {
                    DatabaseReference.shared.walkinReference().document(stud).getDocument { (snap, err) in
                        if err == nil {
                            if let data = snap?.data() {
                            let studT = Mapper<Student>().map(JSON: data)
                            self.students.append(studT!)
                            studArray.append(studT!)
                            completionHandler(studArray)
                        }
                    }
                }
                }
                
            }
        }
    }
}
