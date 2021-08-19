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
            .padding(.top, 8)

            
            
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
            
            List(self.feedbackArr) { feedback in
                VStack(alignment : .leading) {
                    
                    HStack(spacing : 15){
                        Image("personCircle")
                        Text(feedback.name)
                            .font(.system(size: 20, weight: .semibold))
                            .textCase(.uppercase)
                    }
                    .padding(.horizontal)
                    
                    Spacer().frame(maxHeight: 40)
                    
                    
                    HStack {
                        VStack {
                            Image(feedback.rating == 1 ? "notUnderstoodRed" : "notUnderstoodGray")
                            Text("Not Understood")
                        }
                        
                        Spacer()
                        
                        VStack {
                            Image(feedback.rating == 2 ? "partiallyUnderstood" : "partiallyUnderstoodGray")
                            Text("Partially Understood")
                        }
                        
                        Spacer()
                        
                        VStack {
                            Image(feedback.rating == 3 ? "understood" : "understoodGray")
                            Text("Understood")
                        }
                    }
                    .modifier(TextStyle10())
                    
                    Spacer().frame(maxHeight: 40)
                    
                    Text("Comment:")
                        .font(.system(size: 14.0, weight: .semibold, design: .default))
                    
                    Spacer().frame(maxHeight: 10)
                    
                    Text(feedback.comment)
                        .font(.system(size: 14.0))
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight : 276)
                .modifier(GrayShadow())
                .padding(.horizontal, 4)
            }
            .onAppear(perform: {
                        topicVM.loadFeedbacksOfAid(aid: topic.aid) { (feedbacks, avgFeedback)  in
                            self.avgFeedback = avgFeedback
                            self.feedbackArr = feedbacks
                        }})
            .listStyle(PlainListStyle())
            Spacer()
        }
    }
}
