//
//  SessionStore.swift
//  Felix Student
//
//  Created by Mac on 22/04/21.
// snehal@felixtechlabs.com

import Foundation
import FirebaseAuth
import Combine
import ObjectMapper

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    static var shared = SessionStore()
    var user: Users?
    var student: Student?
    @Published var session: User? {didSet {self.didChange.send(self)}}
    var handle: AuthStateDidChangeListenerHandle?

    func listen() {
        
//        handle = Auth.auth().addStateDidChangeListener({ [unowned self] (auth, user) in
//            if let user = user {
//                self.session = User(uid: user.uid, email: user.email!)
//                self.fetchUser()
//            } else {
//                self.session = nil
//            }
//        })
        if (Auth.auth().currentUser?.uid) != nil {
            let uid = Auth.auth().currentUser?.uid
            let email = Auth.auth().currentUser?.email
            self.session = User(uid: uid!, email: email!)
            fetchUser { (isUserExixts) in
                
            }
        } else {
            return
        }
        
    }
    
    func fetchUser(Handler:@escaping (Bool) -> Void) {
        let role = Utility.getRole()
        
        if role == Constants.FACULTY {
            
            DatabaseReference.shared.UsersReference().document(Auth.auth().currentUser!.uid).getDocument { [unowned self] (snapshot, error) in
                if error == nil {
                    if let data = snapshot?.data() {
                        self.user = Mapper<Users>().map(JSON: data)
                        Handler(true)
                    } else {
                        Handler(false)
                    }
                    
                }
            }
        } else if role == Constants.STUDENT {
            DatabaseReference.shared.walkinReference().whereField(Constants.UID, isEqualTo: Auth.auth().currentUser?.uid ?? "").getDocuments { [unowned self] (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("No Documents")
                    Handler(false)
                    return
                }
                if error == nil {
                    for doc in documents {
                        self.student = Mapper<Student>().map(JSON: doc.data())
                        Handler(true)
                    }
                }
            }
        }
    }
    
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            print("Something went wrong while signning out")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func forgotPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            print(error!)
        }
    }
    
    
//    deinit {
//        unbind()
//    }
}


struct User {
    var uid: String
    var email: String
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
