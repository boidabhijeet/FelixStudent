//
//  NotificationViewModel.swift
//  Felix Student
//
//  Created by Mac on 03/06/21.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth
import ObjectMapper

class NotificationViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    init() {
        
    }
    
    func fetchNotifications() {
        DatabaseReference.shared.notificationReference().whereField("sendToUid", isEqualTo: Auth.auth().currentUser?.uid ?? "").getDocuments { [self] (snapshot, error) in
            if let err = error {
                print("Error getting documents: \(String(describing: err))")
            } else {
                for document in snapshot!.documents {
                    let noti = Mapper<Notification>().map(JSON: document.data())
                    notifications.append(noti!)
                }
            }
        }
    }
}
