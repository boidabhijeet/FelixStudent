//
//  SelectRole.swift
//  Felix Student
//
//  Created by Mac on 14/04/21.
//snehal nirupan

import SwiftUI

struct SelectRole: View {
    @State private var action: Int? = 0
    var body: some View {
        VStack {
            Image("Students")
            Image("StudentList")
                .resizable()
            
            Group {
                Text("Please select your role")
                
                NavigationLink(destination: LoginView().environmentObject(SessionStore.shared), tag: 1, selection: $action) {
                    EmptyView()
                }
                .isDetailLink(false)
                NavigationLink(destination: LoginView().environmentObject(SessionStore.shared), tag: 2, selection: $action) {
                    EmptyView()
                }
                .isDetailLink(false)
                //
                //                Text("Your Custom View 1")
                //                    .onTapGesture {
                //                        //perform some tasks if needed before opening Destination view
                //                        self.action = 1
                //                    }
                //                Text("Your Custom View 2")
                //                    .onTapGesture {
                //                        //perform some tasks if needed before opening Destination view
                //                        self.action = 2
                //                    }
                
                
                HStack {
                    
                    Button(action: {
                        UserDefaults.standard.setValue(Constants.FACULTY, forKey: Constants.ROLE)
                        self.action = 1
                    }){
                        
                        HStack(spacing: 10) {
                            Image("facultyBtn")
                            Text("Faculty")
                            
                        }}
                    .font(.title)
                    .padding()
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .background(Color.red)
                    
                    
                    
                    
                    
                    Button(action: {
                        UserDefaults.standard.setValue(Constants.STUDENT, forKey: Constants.ROLE)
                        self.action = 2
                    }){
                        HStack(spacing: 10) {
                            Image("studentBtn")
                            Text("Student")
                        }}.font(.title)
                    .padding()
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .background(Color.red)
                }
            }.padding()
            .shadow(color: Color.gray, radius: 10 )
        }
    }
}

struct SelectRole_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SelectRole()
        }
    }
}
