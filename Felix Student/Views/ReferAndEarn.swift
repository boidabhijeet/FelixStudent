//
//  ReferAndEarn.swift
//  Felix Student
//
//  Created by Mac on 15/04/21.
//

import SwiftUI
import AlertToast

struct ReferAndEarn: View {
    @State  private var fullName = ""
    @State  private var email = ""
    @State  private var contact = ""
    @State private var showToast = false
    @State private var showFullNameErrorToast = false
    @State private var showContactErrorToast = false
    @State private var showEmailErrorToast = false
    
    var body: some View {
        ScrollView {
            VStack {
                Image("ReferandEarn-1")
                    .resizable()
                    .frame(width: 400, height: 250)
                Text("Here's an Awesome")
                    .foregroundColor(.gray
                    )
                Text("Refer & Earn").font(.headline)
                Text("Refer a friend and receive upto ₹1000 as reward").font(.body)
                    .foregroundColor(.gray)
                VStack {
                    TextField("Full Name", text: $fullName)
                        .padding()
                        .border(Color.black)
                    TextField("Email", text: $email)
                        .padding()
                        .border(Color.black)
                    TextField("Contact", text: $contact)
                        .padding()
                        .border(Color.black)
                    
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
                        HStack(spacing: 10) {
                            Text("Submit")
                        }
                    }.padding(10)
                    .frame(maxWidth: 320)
                    .foregroundColor(.white)
                    .background(Color.red)
                } .padding()
                //                } .padding()
                //                .shadow(color: Color.gray, radius: 5 )
            }.navigationTitle("Refer & Earn")
            .navigationBarTitleDisplayMode(.inline)
            .toast(isPresenting: $showToast){
                
                // `.alert` is the default displayMode
                AlertToast(type: .regular, title: ToastAlert.referAndEarn)
            }
            .toast(isPresenting: $showFullNameErrorToast){
                
                // `.alert` is the default displayMode
                AlertToast(type: .regular, title: ToastAlert.FullNameError)
            }
            .toast(isPresenting: $showContactErrorToast){
                
                // `.alert` is the default displayMode
                AlertToast(type: .regular, title: ToastAlert.contactError)
            }
            .toast(isPresenting: $showEmailErrorToast){
                
                // `.alert` is the default displayMode
                AlertToast(type: .regular, title: ToastAlert.emailError)
            }
        }
    }
}

struct ReferAndEarn_Previews: PreviewProvider {
    static var previews: some View {
        ReferAndEarn()
    }
}
