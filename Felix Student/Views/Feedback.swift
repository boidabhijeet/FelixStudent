//
//  Feedback.swift
//  Felix Student
//
//  Created by Mac on 15/04/21.
//

import SwiftUI

struct Feedback: View {
    var topic: Topic
    @State var topicVM = TopicViewModel()
    @State var feedback = Feedbacks()
    func loadFeedback() {
        topicVM.getFeedbackOfParticularStudent(topicId: topic.topicId) { (feedback) in
            self.feedback = feedback
        }
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
            
            VStack(alignment: .leading, spacing: 5) {
                
                HStack {
                    Text("Topic name: ").font(.headline)
                    Text(topic.topic)
                }
                HStack {
                    Text("Hours: ").font(.headline)
                    Text(topic.timeSpent)
                }
                HStack {
                    
                    VStack {
                        Image(topic.rating == 1 ? "icn_notunderstoodselected" : "icn_notunderstood")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("Not Understood").font(.caption)
                    }
                    VStack {
                        Image(topic.rating == 2 ? "icn_partiallyunderstood-1" : "icn_partiallyunderstood")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("Partially Understood").font(.caption)
                    }
                    VStack {
                        Image(topic.rating == 3 ? "icn_understoodselected" : "icn_understood")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("Understood").font(.caption)
                    }
                }
                
                Text("Comment: ").font(.headline)
                Text(feedback.comment)
                
        } .padding(25)
            .onAppear {
                loadFeedback()
            }
            
        }.navigationTitle("Feedback")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .shadow(color: Color.gray, radius: 5 )
    }
}

