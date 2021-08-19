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
    @Environment(\.presentationMode) var presentationMode
//    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    var body: some View {
        GeometryReader { geo in
            
            VStack(spacing : 20) {
                
                Button(
                    action: {self.presentationMode.wrappedValue.dismiss()},
                    label: {
                        HStack{
                            Image(systemName: "arrow.left")
                            Text("Give Feedback")
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth : .infinity, alignment : .leading)
                        .padding(.leading, 15.0)
                        .padding(.top, 8)

                    })
                
                Divider()
                
                VStack(alignment: .leading){
                    
                    HStack {
                        Text("Topic Name :").fontWeight(.semibold)
                        Text(topic.topic)
                        Spacer()
                    }
                    .modifier(TextStyle14())
                    .padding(.vertical, 1)
                    
                    
                    HStack{
                        Text("Hours: ").fontWeight(.semibold)
                        Text(topic.timeSpent)
                    }.modifier(TextStyle14())
                    
                    Spacer()
                    
                    
                    HStack {
                        VStack {
                            Button(action: {
                                self.isNotUnderstood.toggle()
                                self.isPartiallyUnderstood = false
                                self.isUnderstood = false
                                topic.rating = 1
                            }) {
                                Image(self.isNotUnderstood == true ? "notUnderstoodRed" : "notUnderstoodGray")
                            }
                            .buttonStyle(PlainButtonStyle())
                            Text("Not Understood")
                                .lineLimit(0)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Button(action: {
                                self.isPartiallyUnderstood.toggle()
                                self.isNotUnderstood = false
                                self.isUnderstood = false
                                topic.rating = 2
                            }) {
                                Image(self.isPartiallyUnderstood == true ? "partiallyUnderstood" : "partiallyUnderstoodGray")
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
                                Image(self.isUnderstood == true ? "understood" : "understoodGray")
                            }
                            .buttonStyle(PlainButtonStyle())
                            Text("Understood").font(.caption)
                        }
                    }
                    .modifier(TextStyle10())
                    
                    Spacer()
                    
                    
                    TextField("Comments:", text: $comment, onEditingChanged: { (changed) in
                        topic.remarks = comment
                    })
                    Divider()
                        .padding(.horizontal, 1)
                        .frame(height : 0.6)
                        .background(Color.red)
                    
                    Spacer().frame(height: 10)
                    
                    
                    Text("Note*: Feedback will be seen by faculty.")
                        .font(.system(size: 10, weight: .regular))
                        .italic()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 276)
                .modifier(GrayShadow())
                .padding(.horizontal)
                
                Spacer()
                
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
                    self.presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Text("Send Feedback")
                }
                .font(.system(size: 24, weight: .semibold, design: .default))
                .frame(maxWidth: geo.size.width, minHeight: 65, alignment: .center)
                .background(Color.red)
                .foregroundColor(.white)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .toast(isPresenting: $showToast){
            AlertToast(type: .regular, title: ToastAlert.studentFeedbackError)
        }
        .toast(isPresenting: $showalert){
            AlertToast(type: .regular, title: ToastAlert.commentError)
        }
    }
}
