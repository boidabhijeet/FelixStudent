//
//  GeneralFeedbackViewModel.swift
//  Felix Student
//
//  Created by Mac on 29/04/21.
//

import Foundation
import Combine
import FirebaseFirestore

class GeneralFeedbackViewModel: ObservableObject {
    @Published var feddback: GeneralFeedback
    private var cancellables = Set<AnyCancellable>()
    
    init(feedback: GeneralFeedback) {
        self.feddback = feedback
    }
    
    func addGeneralFeedback() {
        let ref = DatabaseReference.shared.generalFeedbackReference().document()
        let id = ref.documentID
        feddback.fid = id
        ref.setData(feddback.toJSON())
    }
}
