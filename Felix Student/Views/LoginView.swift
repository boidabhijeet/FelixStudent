//
//  LoginView.swift
//  Felix Student
//
//  Created by Mac on 14/04/21.
//

import SwiftUI

struct LoginView: View {
    @State private var text : String = ""
    @State var visible = false
    @State private var emailAddress = ""
    @State private var password: String = ""
    @State var error: String = ""
    @State private var showAlert = false;
    let role = Utility.getRole()
    @State var message = ""
    
    var body: some View {
        
        ZStack {
            VStack{
                
                Spacer().frame(maxHeight: 40)
                
                Image("HeaderLogo")
                    .renderingMode(.original)
                    .frame(maxWidth : .infinity, alignment: .center)
                
                Spacer().frame(maxHeight: 60)
                
                Text(message)
                    .font(.system(size: 20))
                    .foregroundColor(.red)
                    .frame(maxWidth : .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .onAppear {
                        self.message = "Good Day \(role),"
                    }
                
                Spacer().frame(maxHeight: 10)
                
                Text("Let's login to the classroom")
                    .font(.system(size: 24))
                    .frame(maxWidth : .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Spacer().frame(maxHeight: 50)
                
                
                Group{
                    
                    TextField("Email", text: $emailAddress)
                        .modifier(CustomTextField())
                    
                    Spacer().frame(maxHeight: 30)
                    
                    HStack(spacing: 15){
                        if self.visible{
                            TextField("Password", text: self.$password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }else{
                            SecureField("Password", text: self.$password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        
                        Button(action: {
                            self.visible.toggle()
                        }) {
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.red)
                        }
                    }
                    .modifier(CustomTextField())
                    
                    
                    Spacer().frame(maxHeight: 50)
                    
                    Button(action: signIn, label: {
                        HStack(spacing: 10) {
                            Text("LOGIN")
                        }
                        .modifier(RedButton())
                        
                    })
       
                    Spacer().frame(maxHeight: 30)
                    
                    Button("Forgot Password?"){
                        self.showAlert = true
                    }
                    .foregroundColor(.black)
                    
                    
                    if error != "" {
                        Text(error)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .padding(.horizontal)
            
            ForgotPwdAlert(isPresented: $showAlert, text: $text)
            
        }
        .background(showAlert ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.1).ignoresSafeArea(.all) : nil)
    }
    
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
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(SessionStore.shared)
    }
}

