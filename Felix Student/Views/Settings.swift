//
//  Settings.swift
//  Felix Student
//
//  Created by Mac on 15/04/21.
//

import SwiftUI

struct Settings: View {
    @State var isActive : Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    var url = ""
    @State private var image = UIImage()
    @ObservedObject var imageLoader:ImageLoader
    
    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }
    func signOut() {
        SessionStore.shared.signOut()
        Router.showLogin()
//        navigationStack.pop(to: .root)
//        self.presentationMode.wrappedValue.dismiss()
        self.rootPresentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100, height:100)
                .opacity(0.8)
                .cornerRadius(50.0)
                .padding(3)
                .overlay(ImageOverlay(), alignment: .bottomTrailing)
                .onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage()
                }

            if Utility.getRole() == Constants.FACULTY {
                Text(SessionStore.shared.user?.fullName ?? "")
                    .font(.caption)
                Text(SessionStore.shared.user?.email ?? "")
                    .font(.system(size: 12))
                
                Divider()
                
                NavigationLink(
                    destination: EditProfile(withURL: SessionStore.shared.user!.photoUrl)) {
                    HStack(spacing: 10) {
                        Image("icn_profile")
                        Text("Profile")
                    }.font(.title)
                    .padding()
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    
                }.isDetailLink(false)
                .frame(minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: 100,
                        alignment: .leading)
            } else if Utility.getRole() == Constants.STUDENT {
                Text(SessionStore.shared.student?.name ?? "")
                    .font(.caption)
                Text(SessionStore.shared.student?.email ?? "")
                    .font(.system(size: 12))
                Divider()
                
                NavigationLink(
                    destination: EditProfile(withURL: SessionStore.shared.student!.photoUrl)) {
                    HStack(spacing: 10) {
                        Image("icn_profile")
                        Text("Profile")
                    }.font(.title)
                    .padding()
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    
                }.isDetailLink(false)
                .frame(minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: 100,
                        alignment: .leading)
            }
            
            
            
            NavigationLink(
                destination: LoginView()) {
                HStack(spacing: 10) {
                    Image("icn_changePassword")
                    Text("Change Password")
                }.font(.title)
                .padding()
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                
            }.isDetailLink(false)
            .frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 100,
                    alignment: .leading)
//            .border(Color.gray).frame(maxWidth: .infinity)
            
            Button(action: signOut, label: {
                HStack(spacing: 10) {
                    Image("icn_logout")
                    Text("Logout")
                }.font(.title)
                .padding()
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                
            }).frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 100,
                    alignment: .leading)
//            .border(Color.gray).frame(maxWidth: .infinity)
        
            Spacer()
        }.padding()
        .navigationBarTitle("")
    }
}
