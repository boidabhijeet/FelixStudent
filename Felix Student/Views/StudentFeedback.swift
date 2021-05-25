//
//  StudentFeedback.swift
//  Felix Student
//
//  Created by Mac on 23/05/21.
//

import SwiftUI

struct StudentFeedback: View {
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Main Method")
                    Spacer()
                    Text("Avg.Feedback")
                    Image(systemName: "edit")
                }
                HStack {
                    Text("Main Method")
                    Spacer()
                    Text("Avg.Feedback")
                    Image(systemName: "edit")
                }
                HStack {
                    Text("Main Method")
                    Spacer()
                    Text("Avg.Feedback")
                    Image(systemName: "edit")
                }
            }
            .onAppear(perform: {
                // code 
            })
        }
        .navigationTitle("Student Feedback")
    }
}

struct StudentFeedback_Previews: PreviewProvider {
    static var previews: some View {
        StudentFeedback()
    }
}
