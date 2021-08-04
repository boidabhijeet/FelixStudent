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
    @Environment(\.presentationMode) var presentationMode

    func loadFeedback() {
        topicVM.getFeedbackOfParticularStudent(topicId: topic.topicId) { (feedback) in
            self.feedback = feedback
        }
    }
    
    var body : some View{
        
        VStack(spacing : 20) {
            
            Button(
                action: {self.presentationMode.wrappedValue.dismiss()},
                label: {
                    HStack{
                        Image(systemName: "arrow.left")
                        Text("Feedback")
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth : .infinity, alignment : .leading)
                    .padding(.leading, 15.0)
                })
            
            Divider()
            
            VStack(alignment: .leading){
                HStack{
                    Text("Topic Name :").fontWeight(.semibold)
                    Text(topic.topic)
                    Spacer()
                    //ToDo :- Make edit functional
                    Image("editIcon").padding()
                }.modifier(TextStyle14())
                
                
                HStack{
                    Text("Hours: ").fontWeight(.semibold)
                    Text(topic.timeSpent)
                }.modifier(TextStyle14())
                
                Spacer()
                
                HStack {
                    
                    VStack {
                        Image(topic.rating == 1 ? "notUnderstoodRed" : "notUnderstoodGray")
                        Text("Not Understood")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Image(topic.rating == 2 ? "partiallyUnderstood" : "partiallyUnderstoodGray")
                        Text("Partially Understood")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Image(topic.rating == 3 ? "understood" : "understoodGray")
                        Text("Understood")
                    }
                }
                .modifier(TextStyle10())
                
                Spacer()
                
                Text("Comment:")
                    .fontWeight(.semibold)
                    .modifier(TextStyle14())
                
                
                Spacer().frame(height: 10)
                
                Text(feedback.comment)
                    .modifier(TextStyle14())
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 276)
            .modifier(GrayShadow())
            .padding(.horizontal)
            Spacer()
        }
        .onAppear {
            loadFeedback()
        }
    }
}

