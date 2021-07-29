//
//  GiveFeedback.swift
//  Felix Student
//
//  Created by Mac on 15/04/21.
//

import SwiftUI
import AlertToast

struct GiveFeedback: View {
    @State private var showToast = false
    @State private var showalert = false
    var topic: Topic
    @ObservedObject var topicVM = TopicViewModel()
    @State  private var comment = ""
    @State var isNotUnderstood : Bool = false
    @State var isPartiallyUnderstood : Bool = false
    @State var isUnderstood : Bool = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    var body: some View {
        
        VStack(alignment: .leading) {
            
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
                    Button(action: {
                        self.isNotUnderstood.toggle()
                        self.isPartiallyUnderstood = false
                        self.isUnderstood = false
                        topic.rating = 1
                    }) {
                        Image(self.isNotUnderstood == true ? "icn_notunderstoodselected" : "icn_notunderstood")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Text("Not Understood").font(.caption)
                    
                }
                Spacer()
                VStack {
                    Button(action: {
                        self.isPartiallyUnderstood.toggle()
                        self.isNotUnderstood = false
                        self.isUnderstood = false
                        topic.rating = 2
                    }) {
                        Image(self.isPartiallyUnderstood == true ? "icn_partiallyunderstood-1" : "icn_partiallyunderstood")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Text("Partially Understood").font(.caption)
                }
                Spacer()
                VStack {
                    Button(action: {
                        self.isUnderstood.toggle()
                        self.isPartiallyUnderstood = false
                        self.isNotUnderstood = false
                        topic.rating = 3
                    }) {
                        Image(self.isUnderstood == true ? "icn_understoodselected" : "icn_understood")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Text("Understood").font(.caption)
                }
            }
            
            TextField("Comments", text: $comment, onEditingChanged: { (changed) in
                topic.remarks = comment
                //print("Username onEditingChanged - \(changed)")
            })
            .textFieldStyle(PlainTextFieldStyle())
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(Color.red)
            
            
            Text("Note: Feedback will be seen by faculty.").font(.caption)
            Button(action: {
                if topic.rating == 0 {
                    showToast = true
                    return
                }
                if comment == "" {
                    showalert = true
                    return
                }
                let feedback = Feedbacks(comment: comment, feedback: comment, rating: topic.rating)
                topicVM.giveFeedback(feedback: feedback, topic: topic)
                self.mode.wrappedValue.dismiss()
                
            }) {
                HStack(spacing: 10) {
                    Text("Send Feedback")
                }
            } .padding(10)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.red)
            
        }.padding(25)
        .navigationTitle("Give Feedback")
        .navigationBarTitleDisplayMode(.inline)
        
        .toast(isPresenting: $showToast){
            AlertToast(type: .regular, title: ToastAlert.studentFeedbackError)
        }
        .toast(isPresenting: $showalert){
            AlertToast(type: .regular, title: ToastAlert.commentError)
        }
    }
}

struct TopicFeedbackRow: View {
    var topicData: Topic
    @State  private var comment = ""
    @State var isNotUnderstood : Bool = false
    @State var isPartiallyUnderstood : Bool = false
    @State var isUnderstood : Bool = false
    @ObservedObject var topicVM = TopicViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    var body: some View {
        VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            
            HStack {
                Text("Topic name: ").font(.headline)
                Text(topicData.topic)
            }
            HStack {
                Text("Hours: ").font(.headline)
                Text(topicData.timeSpent)
            }
            
            HStack {
                VStack {
                    Button(action: {
                        self.isNotUnderstood.toggle()
                        self.isPartiallyUnderstood = false
                        self.isUnderstood = false
                        topicData.rating = 3
                    }) {
                        Image(self.isNotUnderstood == true ? "icn_notunderstoodselected" : "icn_notunderstood")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Text("Not Understood").font(.caption)
                    
                }
                Spacer()
                VStack {
                    Button(action: {
                        self.isPartiallyUnderstood.toggle()
                        self.isNotUnderstood = false
                        self.isUnderstood = false
                        topicData.rating = 2
                    }) {
                        Image(self.isPartiallyUnderstood == true ? "icn_partiallyunderstood-1" : "icn_partiallyunderstood")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Text("Partially Understood").font(.caption)
                }
                Spacer()
                VStack {
                    Button(action: {
                        self.isUnderstood.toggle()
                        self.isPartiallyUnderstood = false
                        self.isNotUnderstood = false
                        topicData.rating = 1
                    }) {
                        Image(self.isUnderstood == true ? "icn_understoodselected" : "icn_understood")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Text("Understood").font(.caption)
                }
            }
            
            TextField("Comments", text: $comment, onEditingChanged: { (changed) in
                topicData.remarks = comment
//                print("Username onEditingChanged - \(changed)")
            })
            .textFieldStyle(PlainTextFieldStyle())
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(Color.red)
            
            //            TextField("Enter username...", text: $comment, onEditingChanged: { (changed) in
            //                            print("Username onEditingChanged - \(changed)")
            //                        })
            Text("Note: Feedback will be seen by faculty.").font(.caption)
            Button(action: {
                let feedback = Feedbacks(comment: topicData.remarks, feedback: topicData.remarks, rating: topicData.rating)
                topicVM.giveFeedback(feedback: feedback, topic: topicData)
                //                self.mode.wrappedValue.dismiss()
                
                self.rootPresentationMode.wrappedValue.dismiss()
            }) {
                HStack(spacing: 10) {
                    Text("Send Feedback")
                }
            } .padding(10)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.red)
        })
        .padding(25)
        //        .border(Color("GrayColor"))
        
    }
}


