//
//  Settings.swift
//  Felix Student
//
//  Created by Mac on 15/04/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct Settings: View {
    @State var isActive : Bool = false
//    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    var url: URL
    @State private var image = UIImage()

    func signOut() {
        SessionStore.shared.signOut()
        for topic in BatchViewModel.subscribedTopics {
            Messaging.messaging().unsubscribe(fromTopic: topic)
        }
        Router.showLogin()
        self.rootPresentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack(spacing : 10) {

            Spacer().frame(maxHeight : 40)

            WebImage(url: url)
                .placeholder(Image("profileImage"))
                .renderingMode(.original)
                .resizable()
                .frame(maxWidth: 79, maxHeight: 79)
                .cornerRadius(39.5)

      
            if Utility.getRole() == Constants.FACULTY {
                Text(SessionStore.shared.user?.fullName ?? "")

                Text(SessionStore.shared.user?.email ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer().frame(maxHeight : 20)

                Divider()
                
                Spacer().frame(maxHeight : 20)

                NavigationLink(
                    destination: EditProfile(url : url)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    label: {
                        HStack(spacing: 19) {
                            Image("profileIcon")
                            Text(" Profile")
                            Spacer()
                        }
                        .padding()
                    })
                
            } else if Utility.getRole() == Constants.STUDENT {
                Text(SessionStore.shared.student?.name ?? "")

                Text(SessionStore.shared.student?.email ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer().frame(maxHeight : 20)

                Divider()
                
                Spacer().frame(maxHeight : 16)

                NavigationLink(
                    destination: EditProfile(url : url)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    label: {
                        HStack(spacing: 19) {
                            Image("profileIcon")
                            Text(" Profile")
                            Spacer()
                        }
                        .padding()
                    })
            }
            
            Spacer().frame(maxHeight: 16)

            NavigationLink(
                destination: Text("Change Password"),
                label: {
                    HStack(spacing: 16) {
                        Image("lockIcon")
                        Text("Change Password")
                        Spacer()
                    }
                    .padding()
                })
            
            Spacer().frame(maxHeight: 16)

            Button(action: signOut, label: {
                
                HStack(spacing: 19) {
                    Image("logoutIcon")
                    Text("Logout")
                    Spacer()
                }
                .padding()
            })
            Spacer()
        }
        .foregroundColor(.black)
        .navigationBarHidden(true)
    }
}
