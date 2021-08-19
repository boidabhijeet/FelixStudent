//
//  ContentView.swift
//  Felix Student
//
//  Created by Mac on 13/04/21.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {

    func getUser() {
        
        SessionStore.shared.listen()
    }
    
    @State private var isActive : Bool = false
    
    var body: some View {
        VStack {
            if Auth.auth().currentUser != nil {
                NavigationView {
                    CustomTabBar()
                }
            } else {
                CustomPageView()
            }
        }.onAppear(perform: {
            getUser()
        })
    }
}
