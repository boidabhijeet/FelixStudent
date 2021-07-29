//
//  StudentFeedback.swift
//  Felix Student
//
//  Created by Mac on 23/05/21.
//

import SwiftUI

struct StudentFeedback: View {
    var topic: Topic
    @State var avgFeedback: Int
    @ObservedObject private var topicVM = TopicViewModel()
    @State var feedbackArr: [Feedbacks] = []
    var body: some View {
        VStack {
                HStack {
                    Text(topic.topic)
                    Spacer()
                    Text("Avg.Feedback")
                    if avgFeedback == 0 {
                        Text("No feedback received")
                    } else if avgFeedback == 1 {
                        Image("icn_notunderstoodselected")
                    } else if avgFeedback == 2 {
                        Image("icn_partiallyunderstood-1")
                    } else if avgFeedback == 3 {
                        Image("icn_understoodselected")
                    }
                }.padding()
                
//            if self.feedbackArr.count != 0 {
                List(self.feedbackArr) { feedback in
                    StudentFeedbackRow(feedback: feedback)
                }.onAppear(perform: {
                    topicVM.loadFeedbacksOfAid(aid: topic.aid) { (feedbacks, avgFeedback)  in
                       
                        self.avgFeedback = avgFeedback
                        self.feedbackArr = feedbacks
                    }
                })
//            }
            
        }
        .navigationTitle("Student Feedback")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StudentFeedbackRow: View {
    var feedback: Feedbacks
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
            
            VStack(alignment: .leading){
                HStack {
                    Image("icn_placeholderImage") .resizable()
                        .frame(width: 60, height: 60)
                    Text(feedback.name)
                }
                HStack {
                    
                    VStack {
                        Image(feedback.rating == 1 ? "icn_notunderstoodselected" : "icn_notunderstood")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("Not Understood").font(.caption)
                    }
                    VStack {
                        Image(feedback.rating == 2 ? "icn_partiallyunderstood-1" : "icn_partiallyunderstood")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("Partially Understood").font(.caption)
                    }
                    VStack {
                        Image(feedback.rating == 3 ? "icn_understoodselected" : "icn_understood")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("Understood").font(.caption)
                    }
                }
                Text("Comment:")
                Text(feedback.comment)
            } .padding()
        }
        .padding(25)
        .border(Color("GrayColor"))
        .shadow(radius: 5 )
        
    }
}
