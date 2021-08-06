//
//  StudentFeedback.swift
//  Felix Student
//
//  Created by Mac on 23/05/21.
//

import SwiftUI

struct StudentFeedback: View {
    var topic: Topic
    @ObservedObject private var topicVM = TopicViewModel()
    @State var feedbackArr: [Feedbacks] = []
    @State var avgFeedback: Int
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment : .leading){
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack{
                    Image(systemName: "arrow.left")
                    Text("Student Feedback")
                }
                .foregroundColor(.black)
            })
            .padding(.horizontal)
            
            
            Divider()
            
            Spacer().frame(maxHeight: 20)
            
            HStack {
                
                Text(topic.topic)
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("Avg. Rating : ")
                    .font(.system(size: 12))
                if avgFeedback == 0 {
                    Text("-")
                } else if avgFeedback == 1 {
                    Image("notUnderstoodRed")
                } else if avgFeedback == 2 {
                    Image("partiallyUnderstood")
                } else if avgFeedback == 3 {
                    Image("understood")
                }
                Spacer().frame(maxWidth: 20)
                
                Image(systemName: "control")
            }
            .padding(.horizontal, 30)
            
            Spacer().frame(maxHeight: 20)
            
//            List{
////                ForEach(feedbackArr.count, id: \.self) { feedback in
////                    StudentFeedbackRow(feedback: feedback)
////                }
//
//                  ForEach(0 ..< feedbackArr.count, id: \.id) { feedback in
//                    StudentFeedbackRow(feedback: feedback)
//                }
            
//            }
//            .onAppear(perform: {
//                topicVM.loadFeedbacksOfAid(aid: topic.aid) { (feedbacks, avgFeedback)  in
//                    self.avgFeedback = avgFeedback
//                    self.feedbackArr = feedbacks
//                }
//            })

            List(self.feedbackArr) { feedback in
                Section{
                    StudentFeedbackRow(feedback: feedback)
                }
            }
            .onAppear(perform: {
                topicVM.loadFeedbacksOfAid(aid: topic.aid) { (feedbacks, avgFeedback)  in
                    self.avgFeedback = avgFeedback
                    self.feedbackArr = feedbacks
                }
            })
//            .listStyle(PlainListStyle())
        }
    }
}
