//
//  ReferAndEarn.swift
//  Felix Student
//
//  Created by Mac on 15/04/21.
//

import SwiftUI

struct ReferAndEarn: View {
    @State  private var fullName = ""
    @State  private var email = ""
    @State  private var contact = ""
    
    var body: some View {
//        NavigationView {
            VStack {
                Text("Here's an Awesome")
                Text("Refer & Earn").font(.headline)
                Text("Refer a friend and receive upto ₹1000 as reward").font(.body)
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color.white)
                    
                VStack {
                    TextField("Full Name", text: $fullName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("Contact", text: $contact)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button(action: {
                        print("Refer and Earn")
                        let name = SessionStore.shared.user?.fullName
                        let timestamp = NSDate().timeIntervalSince1970
                        let uid = SessionStore.shared.session!.uid
                        let ref = Reference(byName: name!, contact: contact, createdAt: Int64(timestamp), email: email, fullName: fullName, source: "Reference", uid: uid)
                       let refVM = ReferenceViewModel(reference: ref)
                        refVM.addReference()
                           email = ""
                        contact = ""
                        fullName = ""
                    }) {
                        HStack(spacing: 10) {
                            Text("Submit")
                        }
                    }.padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.red)
                } .padding()
                }
            }.navigationTitle("Refer & Earn")
        }
//    }
}

struct ReferAndEarn_Previews: PreviewProvider {
    static var previews: some View {
        ReferAndEarn()
    }
}
