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
    @State private var text = ""
    @State private var showToast = false
    @State private var showErrorToast = false
    var frameworks = ["Poor", "Bad", "Okay", "Good", "Great"]
    @State private var selectedFrameworkIndex = 0
    var body: some View {
        VStack {
            Form {
            Text("Do you have any suggestion or issue? \n Please feel free to let us know..")
//            TextEditor(text: $comment)
//                .padding()
//                .background(Color.init(.sRGB, red: 255, green: 199, blue: 203, opacity: 1))
//                .foregroundColor(.black)
//                .border(Color.black)
                ZStack(alignment: .topLeading) {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color(UIColor.secondarySystemBackground))
                            
                            if text.isEmpty {
                                Text("Describe your issue or idea")
                                    .foregroundColor(Color(UIColor.placeholderText))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 12)
                                    
                            }
                            
                            TextEditor(text: $text)
                                .padding(4)
                            
                        }
                        .frame(width: 300, height: 400)
                        .font(.body)
            Text("How do you feel? (optional)")
            Picker(selection: $selectedFrameworkIndex, label: Text("")) {
                ForEach(0 ..< frameworks.count) {
                    Text(self.frameworks[$0])
                }
            }
            Spacer()
            
            Button(action: {
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
            }) {
                HStack(spacing: 10) {
                    Text("Save")
                }
            }.padding(10)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.red)
            }
        }.navigationTitle("Give Feedback")
        .navigationBarTitleDisplayMode(.inline)
        .toast(isPresenting: $showToast){
            
            // `.alert` is the default displayMode
            AlertToast(type: .regular, title: ToastAlert.felixFeedback)
        }
        
        .toast(isPresenting: $showErrorToast){
            
            // `.alert` is the default displayMode
            AlertToast(type: .regular, title: ToastAlert.feedbackError)
        }
    }
//}
}

struct FelixFeedback_Previews: PreviewProvider {
    static var previews: some View {
        FelixFeedback()
    }
}
