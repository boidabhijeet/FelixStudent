//
//  FelixFeedback.swift
//  Felix Student
//
//  Created by Mac on 15/04/21.
//

import SwiftUI

struct FelixFeedback: View {
    @State  private var comment = ""
    var frameworks = ["Poor", "Bad", "Okay", "Good", "Great"]
    @State private var selectedFrameworkIndex = 0
    var body: some View {
//        NavigationView {
        VStack {
            Form {
            Text("Do you have any suggestion or issue? \n Please feel free to let us know..")
            TextEditor(text: .constant("Describe your issue or idea"))
                .padding()
                .background(Color.init(.sRGB, red: 255, green: 199, blue: 203, opacity: 1))
                .foregroundColor(.black)
                .border(Color.black)
            Text("How do you feel? (optional)")
            Picker(selection: $selectedFrameworkIndex, label: Text("")) {
                ForEach(0 ..< frameworks.count) {
                    Text(self.frameworks[$0])
                }
            }
            Spacer()
            
            Button(action: {
                print("Edit button was tapped")
                let name = SessionStore.shared.user?.fullName
                let uid = SessionStore.shared.session!.uid
                let feedback = GeneralFeedback(byName: name!, rating: "\(selectedFrameworkIndex)", reply: "", title: comment, uid: uid)
               let feedbackVM = GeneralFeedbackViewModel(feedback: feedback)
                feedbackVM.addGeneralFeedback()
                comment = ""
            }) {
                HStack(spacing: 10) {
                    Text("Save")
                }
            }.padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.red)
            }
        }.navigationTitle("Give Feedback")
    }
//}
}

struct FelixFeedback_Previews: PreviewProvider {
    static var previews: some View {
        FelixFeedback()
    }
}
