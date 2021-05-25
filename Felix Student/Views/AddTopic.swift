//
//  AddTopic.swift
//  Felix Student
//
//  Created by Mac on 16/04/21.
//

import SwiftUI
import AlertToast

struct AddTopic: View {
    @State var batchDate = Date().timeIntervalSince1970
    @State var date = Date()
    @State private var showModal = false
    var batch: Batch
    @State var aid: String
    @ObservedObject var topicVM = TopicViewModel()
    var batchString = ""
    var fromPlusButton: Bool
    var topic: Topic?
    @Binding var rootIsActive : Bool
    @State var batchDateString: String
    @State var isActive : Bool
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @State private var showToast = false
    @State private var disableButton = false

    func stringDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(batchDate))
        let dateFormatter = DateFormatter()
        //        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    func onLoad() {
        if !fromPlusButton {
            batchDate = TimeInterval(topic!.dateCreatedAt)
            date = Date(timeIntervalSince1970: TimeInterval(batchDate))
        }
    }
    func onCheck(selectedDate: String) {
        self.topicVM.checkTopicsAePresentAtDate(selectedDate: selectedDate, batchId: batch.batchId) { (presentAtt) in
            print(presentAtt)
            if presentAtt {
                showToast = true
                disableButton = true
            } else {
                showToast = false
                disableButton = false
            }
//            loadTopics()
            
        }
    }
    func loadTopics() {
//        topicVM.loadTopicsOfAid(aid: aid) { (topics, avgFeedback, covered) in
//            topicVM.topicsOfSameAid = topics
//        }
        topicVM.loadTopicsForAttendance(date: batchDateString, batchId: batch.batchId) { (topicArray, avgFeedback, coveredHrs) in
            
        }
    }
    var body: some View {
        //        NavigationView {
        VStack {
            ZStack {
                HStack {
                    
                    Text("Session Date: \(stringDate())").font(.headline)
                        .onAppear {
                            onLoad()
                        }
                    DatePicker("label", selection: $date, displayedComponents: [.date])
                        .datePickerStyle(CompactDatePickerStyle())
                        .labelsHidden()
                        .onChange(of: date) {
                            print($0)
                            batchDate = $0.timeIntervalSince1970
                            let formate = $0.getFormattedDate(format: "dd MMM,yyyy") // Set output formate
                            batchDateString = formate
                            onCheck(selectedDate: formate)
                            
                        }
                }
            }
            List(topicVM.topicsOfSameAid, id: \.id) { feedback in
                AddTopicRow(topicData: feedback)
            }
//            .onAppear(perform: {
//                loadTopics()
//            })
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: AddNewTopic(showModal: $showModal, batch: batch, topicData: topic ?? Topic(), rootIsActive: self.$rootIsActive, isActive: isActive)) {
                        HStack(spacing: 10) {
                            Text("+ click to add topic")
                                .frame(width: 177, height: 70)
                                .foregroundColor(Color.black)
                                .padding(.bottom, 7)
                        }
                    }
                    .isDetailLink(false)
                    .background(Color.white)
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3)
                    
                }
            }.disabled(disableButton == true)
            
            NavigationLink(destination: MarkAttendance(newTopics: DatabaseReference.shared.topicArray, batch: batch, shouldPopToRootView: $isActive)
            ) {
                HStack(spacing: 10) {
                    Text("Next")
                }
            }.padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.red)
            .disabled(disableButton == true)
        }.navigationTitle("Add Topic")
        .toast(isPresenting: $showToast){
            
            // `.alert` is the default displayMode
            AlertToast(type: .regular, title: ToastAlert.attendanceMarked)
        }
    }
    //}
}

struct AddTopicRow: View {
    var topicData: Topic
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text(topicData.topic)
                Spacer()
                Button(action: {
                    print("Edit button was tapped")
                }) {
                    HStack(spacing: 10) {
                        Image("icn_threedots")
                    }
                }
            }
            Text(topicData.remarks)
            Text(topicData.timeSpent)
            
        }
        .padding(25)
        .border(Color("GrayColor"))
        .shadow(radius: 10 )
        
    }
}

