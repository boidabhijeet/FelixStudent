//
//  LoginView.swift
//  Felix Student
//
//  Created by Mac on 14/04/21.
//

import SwiftUI

struct LoginView: View {
    @State private var emailAddress = "snehal@felixtechlabs.com"
    @State private var password: String = "snehal@123"
    @State var error: String = ""
    @State private var showAlert = false;
    let role = Utility.getRole()
    @State var message = ""
    
    func signIn() {
        SessionStore.shared.signIn(email: emailAddress, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.emailAddress = ""
                self.password = ""
                SessionStore.shared.fetchUser()
                Router.showTabbar()
//                navigationStack.push(Tabbar(), withId: "tabbar")
            }
        }
    }
    
    var body: some View {
        
        VStack {
            Image("Students")
            Text(message).foregroundColor(Color(red: 237/255, green: 28/155, blue: 36/255))
                .onAppear {
                    self.message = "Good Day \(role),"
                }
            Text("Let's login to the classroom")
            
            TextField("Email", text: $emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Enter a Password", text: $password).padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: signIn, label: {
                HStack(spacing: 10) {
                    Text("Login")
                }.font(.title)
                .padding()
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .frame(width: 350.0, height: 50.0)
                .background(Color.red)
                
            })
            
            if error != "" {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: { self.showAlert = true }) {
                Text("Forgot Password?")
            }.alert(isPresented: $showAlert,
                    TextAlert(title: "Enter your email to send reset link",
                              message: "",
                              keyboardType: .emailAddress) { result in
                        if (result != nil) {
                            // Text was accepted
                            SessionStore.shared.forgotPassword(email: result!)
                        } else {
                            // The dialog was cancelled
                        }
                    })
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(SessionStore.shared)
    }
}
