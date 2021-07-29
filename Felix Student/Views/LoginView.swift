//
//  LoginView.swift
//  Felix Student
//
//  Created by Mac on 14/04/21.
//

import SwiftUI

struct LoginView: View {
    @State private var emailAddress = ""
    @State private var password: String = ""
//    @State private var emailAddress = "testsnehal@gmail.com"
//    @State private var password: String = "17557767"
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
                SessionStore.shared.fetchUser { (isUserExists) in
                    if isUserExists {
                        Router.showTabbar()
                    } else {
                        self.error = ToastAlert.userNotfound
                        SessionStore.shared.signOut()
                    }
                }
//                Router.showTabbar()
            }
        }
    }
    
    var body: some View {
       
        VStack(spacing: 20) {
            Spacer()
            Image("Students")
            Spacer()
            VStack(alignment: .leading, spacing:20) {
                Text(message).foregroundColor(Color(red: 237/255, green: 28/155, blue: 36/255))
                    .onAppear {
                        self.message = "Good Day \(role),"
                    }
                Text("Let's login to the classroom")
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .topLeading)
            .padding()
            
            VStack {
                TextField("Email", text: $emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                SecureField("Enter a Password", text: $password).padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: signIn, label: {
                    HStack(spacing: 10) {
                        Text("Login")
                    }.font(.title3)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 350.0, height: 30.0)
                    .background(Color.red)
                    .cornerRadius(3.0)
                    .padding(10)
                })
                
                if error != "" {
                    Text(error)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: { self.showAlert = true }) {
                    Text("Forgot Password?")
                }.foregroundColor(.black)
                .alert(isPresented: $showAlert,
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(SessionStore.shared)
    }
}
