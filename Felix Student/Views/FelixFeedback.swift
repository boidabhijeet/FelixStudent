//
//  FelixFeedback.swift
//  Felix Student
//
//  Created by Mac on 15/04/21.
//

import SwiftUI
import AlertToast
import Firebase

struct FelixFeedback: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var text = ""
    @State private var showToast = false
    @State private var showErrorToast = false
    var frameworks = ["Poor", "Bad", "Okay", "Good", "Great"]
    @State private var selectedFrameworkIndex = 0
    var body: some View {
        GeometryReader { geo in
            VStack{
                Button(
                    action: {
                        self.presentationMode.wrappedValue.dismiss()},
                    label: {
                        HStack(spacing : 10){
                            Image(systemName: "arrow.left")
                            Text("Give Feedback")
                                .font(.system(size: 20))
                        }
                        .frame(maxWidth: geo.size.width * 0.9, alignment: .leading)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                    })
                
                Divider()
                
                Text("Do you have any suggestion or issue?\nPlease feel free to let us know...")
                    .frame(maxWidth: geo.size.width * 0.9, alignment: .leading)
                    .padding()
                
                TextField("Describe your issue or idea...", text: $text)
                    .modifier(TextStyle14())
                    .padding(10)
                    .frame(maxWidth: geo.size.width * 0.9, minHeight: 130, alignment: .topLeading)
                    .background(Color(red: 1.0, green: 0.78, blue: 0.796))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.horizontal)
                
                Text("How do you feel? (Optional)")
                    .font(.system(size: 16))
                    .frame(maxWidth: geo.size.width * 0.9, alignment: .leading)
                    .padding(.top, 30)
                    .padding(.horizontal)
                
                Image("FeedbackEmoji")
                    .frame(maxWidth: geo.size.width, alignment: .center)
                //Paste below HStack here and remove above static image.
//                Picker(selection: $selectedFrameworkIndex, label: Text("")) {
//                    ForEach(0 ..< frameworks.count) {
//                        Text(self.frameworks[$0])
//                    }
//                }
                
                Spacer()
            
                Button("Send") {
                    if text == "" {
                        showErrorToast = true
                        return
                    }
                    var name = ""
                    if let student = SessionStore.shared.student {
                        name = student.name
                    }
                    if let faculty = SessionStore.shared.user {
                        name = faculty.fullName
                    }
                    let uid = Auth.auth().currentUser?.uid
                    let feedback = GeneralFeedback(byName: name, rating: "\(selectedFrameworkIndex)", reply: "", title: text, uid: uid ?? "")
                   let feedbackVM = GeneralFeedbackViewModel(feedback: feedback)
                    feedbackVM.addGeneralFeedback()
                    text = ""
                    showToast = true
                }
                .font(.system(size: 24, weight: .semibold, design: .default))
                .frame(maxWidth: geo.size.width, minHeight: 65, alignment: .center)
                .background(Color.red)
                .foregroundColor(.white)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct FelixFeedback_Previews: PreviewProvider {
    static var previews: some View {
        FelixFeedback()
    }
}
