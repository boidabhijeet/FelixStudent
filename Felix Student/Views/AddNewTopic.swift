//
//  AddNewTopic.swift
//  Felix Student
//
//  Created by Mac on 16/04/21.
//

import SwiftUI
import AlertToast

struct AddNewTopic: View {
    @State  private var topic = ""
    @State  private var note = ""
    @Binding var showModal: Bool
    @State private var time = 0.0
    var batch: Batch
    var topicData: Topic
    @State var futureTopic = Topic()
    @State private var showToast = false
    @Binding var rootIsActive : Bool
//    @Environment(\.presentationMode) private var presentationMode
    @State var isActive : Bool
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

//    @Binding var value: Float = 10.0
    var body: some View {
        VStack {
           
            Text("Add topic and Time spent on it")
            TextField("Topic", text: $topic)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Note (Optional)", text: $note)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("Time spent")
            Slider(value: $time, in: 1...8)
                .padding()
                
            Text("Note*: Time cannot change once you add.")
            
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 10) {
                        Text("Cancel")
                    }
                }.padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.red)
                
                
//                NavigationLink(destination: MarkAttendance(newTopic: futureTopic, batch: batch, shouldPopToRootView: self.$rootIsActive, isActive: isActive)) {
                Button(action: {
                    if topic == "" || note == "" || time == 0.0 {
                        showToast = true
                    } else {
                        futureTopic = Topic(aid: "", batchId: batch.batchId, batchModule: batch.module, date: topicData.date, dateCreatedAt: topicData.dateCreatedAt, remarks: note, timeSpent: String(format: "%.2f hr(s)", time), timespentmints: Int(time*60), topic: topic)
                        showModal = false
                        DatabaseReference.shared.topicArray.append(futureTopic)
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 10) {
                        Text("Ok")
                    }.padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.red)
                }
            }
//            .toast(isPresenting: $showToast){
//                
//                // `.alert` is the default displayMode
//                AlertToast(type: .regular, title: "Message Sent!")
//            }
        }
    }
}


