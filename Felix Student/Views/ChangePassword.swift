//
//  ChangePassword.swift
//  Felix Student
//
//  Created by Abhi on 16/08/21.
//

import SwiftUI
import FirebaseAuth
import AlertToast

struct ChangePassword: View {
    
    @ObservedObject var userSettings = UserSettings()
    @Environment(\.presentationMode) private var presentationMode
    @State private var password: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showToast1 = false
    @State private var showToast2 = false
    @State private var showToast3 = false
    @State private var showToast4 = false
    @State private var errStr : String = ""

    var body: some View {
        VStack{
            
            Button(
                action: {self.presentationMode.wrappedValue.dismiss()},
                label: {
                    HStack{
                        Image(systemName: "arrow.left")
                        Text("Change Password")
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth : .infinity, alignment : .leading)
                    .padding(.leading, 15.0)
                    .padding(.top, 8)
                })
            
            Divider()
            
            Spacer().frame(maxHeight : 32)
            
            SecureField("Current Password", text: $password)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .modifier(CustomTextField())
                .padding(2)
            
            
            SecureField("New Password", text: $newPassword)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .modifier(CustomTextField())
                .padding(2)
            
            
            SecureField("Confirm Password", text: $confirmPassword)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .modifier(CustomTextField())
                .padding(2)
            
            Button("Reset"){
                changePassword()
            }
            .modifier(RedButton())
            
            Spacer()
        }
        .toast(isPresenting: $showToast1){
            AlertToast(type: .regular, title: ToastAlert.samePasswordError)
        }
        .toast(isPresenting: $showToast2){
            AlertToast(type: .regular, title: ToastAlert.wrongPasswordError)
        }
        .toast(isPresenting: $showToast3){
            AlertToast(type: .regular, title: ToastAlert.passwordUpdated)
        }
        .toast(isPresenting: $showToast4){
            AlertToast(type: .regular, title: errStr)
        }
    }
    
    func changePassword(){
        if userSettings.password == newPassword{
            showToast1.toggle()
            return
        }
        
        if newPassword != confirmPassword {
            showToast2.toggle()
            return
        }
        
        // i. Re-authenticate User:
        let user = Auth.auth().currentUser
        let credential: AuthCredential
        credential = EmailAuthProvider.credential(withEmail: userSettings.username, password: userSettings.password)
        
        user?.reauthenticate(with: credential) { (result, error) in
            if let error = error {
                self.errStr = error.localizedDescription
                showToast4.toggle()
                return
            }
            
            Auth.auth().currentUser?.updatePassword(to: newPassword) { (error) in
                userSettings.password = newPassword
                showToast3.toggle()
            }
            
        }
    }
}
