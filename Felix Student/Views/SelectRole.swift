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
            
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white)
                
                
                NavigationLink(destination: LoginView().environmentObject(SessionStore.shared), tag: 1, selection: $action) {
                    EmptyView()
                }
                .isDetailLink(false)
                NavigationLink(destination: LoginView().environmentObject(SessionStore.shared), tag: 2, selection: $action) {
                    EmptyView()
                }
                .isDetailLink(false)
                VStack {
                    Spacer()
                    Text("Please select your role")
                    Spacer()
                    HStack {
                        
                        Button(action: {
                            UserDefaults.standard.setValue(Constants.FACULTY, forKey: Constants.ROLE)
                            self.action = 1
                        }){
                            
                            HStack(spacing: 10) {
                                Image("facultyBtn")
                                Text("Faculty")
                                
                            }}
                        .font(.title3)
                        .padding(10)
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
                            }}.font(.title3)
                        .padding(10)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .background(Color.red)
                    }
                    NavigationLink(destination: EmptyView(), label: {})
                    Spacer()
                }
            }.padding()
            .shadow(color: Color.gray, radius: 5 )
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
