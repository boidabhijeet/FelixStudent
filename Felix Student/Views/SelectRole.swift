//
//  SelectRole.swift
//  Felix Student
//
//  Created by Mac on 14/04/21.
//snehal nirupan

import SwiftUI

struct SelectRole: View {

    @State private var action: Int? = 0
    var screenSize = UIScreen.main.bounds

    var body: some View {
        VStack {
            Spacer()
            
            Image("HeaderLogo")
            
            Image("SelectRole")
                      
            Spacer()

            ZStack {
                
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
                    Text("Please select your role.")
                        .font(.system(size: 23.0))
                        .frame(maxWidth : .infinity, alignment: .topLeading)
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                    
                    HStack {
                        Button(action: {
                            UserDefaults.standard.setValue(Constants.FACULTY, forKey: Constants.ROLE)
                            self.action = 1
                        }, label: {
                            HStack{
                                Image("FacultyIcon")
                                Text("Faculty")
                            }
                            .modifier(RedButton())
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            UserDefaults.standard.setValue(Constants.STUDENT, forKey: Constants.ROLE)
                            self.action = 2
                        }, label: {
                            HStack{
                                Image("StudentIcon")
                                Text("Student")
                            }
                            .modifier(RedButton())
                        })
                        Spacer()
                    }
                    .padding(.bottom, 30)
                    
                    NavigationLink(destination: EmptyView(), label: {})
                    Spacer()
                }
                .padding()
                .frame(maxWidth : screenSize.width, maxHeight: screenSize.height * 0.25)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(radius: 5)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SelectRole_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SelectRole()
        }
    }
}

