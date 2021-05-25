//
//  ReferenceViewModel.swift
//  Felix Student
//
//  Created by Mac on 24/04/21.
//

import Foundation
import Combine
import FirebaseFirestore

class ReferenceViewModel: ObservableObject {
    @Published var reference: Reference
    private var cancellables = Set<AnyCancellable>()
    
    init(reference: Reference) {
        self.reference = reference
    }
    
    func addReference() {
        let ref = DatabaseReference.shared.studentRefReference().document()
        let id = ref.documentID
        reference.rid = id
        ref.setData(reference.toJSON())
    }
}
