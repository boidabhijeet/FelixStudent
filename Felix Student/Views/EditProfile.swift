//
//  EditProfile.swift
//  Felix Student
//
//  Created by Mac on 15/04/21.
//

import SwiftUI
import Combine
import UIKit
import SDWebImageSwiftUI
import AlertToast

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}


struct ImageOverlay: View {
    
    var body: some View {
        ZStack {
            Button(action: {
            }) {
                Image("icn_camera")
                    .padding(3)
                    .foregroundColor(.white)
            }
        }
        .opacity(0.8)
        .cornerRadius(10.0)
        .padding(3)
    }
}
struct EditProfile: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var mobile = ""
    @StateObject var studentVM = StudentViewModel()
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State var url: URL
    @State private var showToast = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    //    @ObservedObject var imageLoader:ImageLoader
    //
    //    init(withURL url:String) {
    //        imageLoader = ImageLoader(urlString:url)
    //    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                //            WebImage(url: URL(string: url))
                //                .onSuccess { (image, data, cache) in
                //
                //                }
                //                .placeholder(Image("icn_placeholderImage"))
                //                .resizable()
                //                .aspectRatio(contentMode: .fit)
                //                .frame(width:100, height:100)
                //                .opacity(0.8)
                //                .cornerRadius(50.0)
                //                .padding(3)
                
                WebImage(url: url)
                    .placeholder(Image("icn_placeholderImage"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:100, height:100)
                    .opacity(0.8)
                    .cornerRadius(50.0)
                    .padding(3)
                
                //                .overlay({
                //                    ZStack {
                //                        Button(action: {
                //                            self.isShowPhotoLibrary = true
                //                        }) {
                //                            Image("icn_camera")
                //                                .padding(3)
                //                                .foregroundColor(.white)
                //                        }
                //                    }
                //                    .sheet(isPresented: $isShowPhotoLibrary) {
                //                        ImagePicker(selectedImage: self.$image, sourceType: .photoLibrary)
                //                    }
                //
                //                }(), alignment: .bottomTrailing)
                //                .onReceive(imageLoader.didChange) { data in
                //                    self.image = UIImage(data: data) ?? UIImage()
                //                }
                
                
                //            Text("Change Profile Picture").foregroundColor(Color.gray)
                Divider()
                VStack(alignment: .leading) {
                    Text("Name") .padding()
                    TextField("Full Name", text: $fullName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Text("Email") .padding()
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Text("Mobile") .padding()
                    TextField("Mobile", text: $mobile)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.mode.wrappedValue.dismiss()
                        }) {
                            HStack(spacing: 10) {
                                
                                Text("Cancel")
                            }
                        } .padding(10).border(Color.red).foregroundColor(.red
                        )
                        Button(action: {
                            let role = Utility.getRole()
                            if role == Constants.FACULTY {
                                studentVM.saveProfileOfFaculty(email: email, fullName: fullName, contact: mobile)
                            } else {
                                studentVM.saveProfile(email: email, fullName: fullName, contact: mobile)
                            }
                            showToast = true
                        }) {
                            HStack(spacing: 10) {
                                
                                Text("Update")
                            }
                        }
                        .padding(10).border(Color.gray).foregroundColor(.white)
                        .background(Color.red)
                        
                        Spacer()
                    }
                }.onAppear(perform: {
                    if Utility.getRole() == Constants.FACULTY {
                        if let faculty = SessionStore.shared.user {
                            email = faculty.email
                            mobile = String(faculty.mobileNumber)
                            fullName = faculty.fullName
                        }
                    }
                    else if Utility.getRole() == Constants.STUDENT {
                        if let student = SessionStore.shared.student {
                            email = student.email
                            mobile = String(student.contact)
                            fullName = student.name
                        }
                    }
                    
                    
                })
                Spacer()
            }.navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toast(isPresenting: $showToast){
                
                // `.alert` is the default displayMode
                AlertToast(type: .regular, title: ToastAlert.profileChanged)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
