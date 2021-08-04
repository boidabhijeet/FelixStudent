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

struct EditProfile: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var mobile = ""
    @StateObject var studentVM = StudentViewModel()
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State var url: URL
    @State private var showToast = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                    HStack{
                        Image(systemName: "arrow.left")
                        Text("Profile")
                        Spacer()
                    }
                    .padding(.horizontal)
                    .foregroundColor(.black)
            })
 
            Group{
       
                Divider()

                Spacer().frame(maxHeight: 20)
                
                WebImage(url: url)
                    .placeholder(Image("profileImage"))
                    .renderingMode(.original)
                    .resizable()
                    .frame(maxWidth: 79, maxHeight: 79)
                    .cornerRadius(39.5)


//                    .aspectRatio(contentMode: .fit)
                
                Spacer().frame(maxHeight: 20)
                
                Text("Change Profile Picture")
                    .foregroundColor(.gray)

                Spacer().frame(maxHeight: 20)

                Divider()
            }
           
            VStack(alignment : .leading){
                Spacer().frame(maxHeight : 20)
                
                Text("Name")
                    .padding(.horizontal)
                TextField("Full Name", text: $fullName)
                    .modifier(CustomTextField())
                
                Spacer().frame(maxHeight: 20)
                
                Text("Email")
                    .padding(.horizontal)
                TextField("Email", text: $email)
                    .modifier(CustomTextField())

               
                Spacer().frame(maxHeight: 20)
                
                Text("Mobile")
                    .padding(.horizontal)
                TextField("Mobile", text: $mobile)
                    .modifier(CustomTextField())
            }
            
            Spacer().frame(maxHeight : 30)

            HStack{
                Spacer()
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .frame(maxWidth : 80, maxHeight: 34)
                .border(Color.red)
                .background(Color.white)
                .foregroundColor(.red)
                .font(.system(size: 15, weight: .regular, design: .default))
                Spacer().frame(width: 20)
                Button("Update") {
                    let role = Utility.getRole()
                    if role == Constants.FACULTY {
                        studentVM.saveProfileOfFaculty(email: email, fullName: fullName, contact: mobile)
                    } else {
                        studentVM.saveProfile(email: email, fullName: fullName, contact: mobile)
                    }
                    showToast = true
                }
                .frame(maxWidth : 80, maxHeight: 34)
                .background(Color.red)
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .regular, design: .default))
            }
            .padding(.horizontal)
            .onAppear(perform: {
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
        }
        .toast(isPresenting: $showToast){
            
            // `.alert` is the default displayMode
            AlertToast(type: .regular, title: ToastAlert.profileChanged)
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
