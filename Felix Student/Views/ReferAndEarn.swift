//
//  ReferAndEarn.swift
//  Felix Student
//
//  Created by Mac on 15/04/21.
//

import SwiftUI
import AlertToast

struct ReferAndEarn: View {
    @Environment(\.presentationMode) var presentationMode

    @State  private var fullName = ""
    @State  private var email = ""
    @State  private var contact = ""
    @State private var showToast = false
    @State private var showFullNameErrorToast = false
    @State private var showContactErrorToast = false
    @State private var showEmailErrorToast = false
    
    var body: some View {
        VStack {
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack{
                    Image(systemName: "arrow.left")
                    Text("Refer & Earn")
                    Spacer()
                }.padding(.horizontal)
                .foregroundColor(.black)
            })
            
            Divider()
            
            Image("ReferAndEarn-1")
                .renderingMode(.original)
                .resizable()
                .frame(maxWidth : .infinity, maxHeight: .infinity)

            
            Spacer()
            
            Text("Here'a an Awesome")
            Text("Refer & Earn!").font(.title3)
            Text("Refer a friend and recieve upto ₹1000 as reward").font(.subheadline)
            
            Spacer()
            
            VStack{
                Group{
                    
                    TextField("Full Name", text: $fullName)

                    TextField("Email", text: $email)

                    TextField("Contact", text: $contact)
                    
                }
                .modifier(CustomTextField())
                // FelixManagement View Call
                
                Button(action: {
                    if fullName == "" {
                        showFullNameErrorToast = true
                        return
                    } else if !contact.isPhoneNumber {
                        showContactErrorToast = true
                        return
                    } else if !Utility.isValidEmail(email) && email != "" {
                        showEmailErrorToast = true
                        return
                    }
                    var name = ""
                    if let student = SessionStore.shared.student {
                        name = student.name
                    }
                    if let faculty = SessionStore.shared.user {
                        name = faculty.fullName
                    }
                    let timestamp = NSDate().timeIntervalSince1970
                    let uid = SessionStore.shared.session!.uid
                    let ref = Reference(byName: name, contact: contact, createdAt: Int64(timestamp), email: email, fullName: fullName, source: "Reference", uid: uid)
                    let refVM = ReferenceViewModel(reference: ref)
                    refVM.addReference()
                    showToast = true
                    email = ""
                    contact = ""
                    fullName = ""
                }) {
                    Text("SUBMIT")
                        .font(.system(size: 16, weight: .semibold))
                        .modifier(RedButton())
                }
            }
            .padding()
            .modifier(GrayShadow())
            .padding(10)
        }
        .toast(isPresenting: $showToast){
            AlertToast(type: .regular, title: ToastAlert.referAndEarn)
        }
        .toast(isPresenting: $showFullNameErrorToast){
            AlertToast(type: .regular, title: ToastAlert.FullNameError)
        }
        .toast(isPresenting: $showContactErrorToast){
            AlertToast(type: .regular, title: ToastAlert.contactError)
        }
        .toast(isPresenting: $showEmailErrorToast){
            AlertToast(type: .regular, title: ToastAlert.emailError)
        }
    }
}

struct ReferAndEarn_Previews: PreviewProvider {
    static var previews: some View {
        ReferAndEarn()
    }
}
