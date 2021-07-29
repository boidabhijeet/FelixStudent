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
    @State private var showfutureToast = false
    @State private var showAtLeastToat = false
    @State private var disableButton = false
    @State private var showingAlert = false
    @State private var isShowingDetailView: Int? = 0
    
    func stringDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(batchDate))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    func onLoad() {
        if let topic = topic {
            batchDate = TimeInterval(topic.dateCreatedAt)
        }
        
        date = Date(timeIntervalSince1970: TimeInterval(batchDate))
        let formate = date.getFormattedDate(format: "dd MMM, yyyy") // Set output formate
        batchDateString = formate
        onCheck(selectedDate: batchDateString)
    }
    func onCheck(selectedDate: String) {
        self.topicVM.checkTopicsAePresentAtDate(selectedDate: selectedDate, batchId: batch.batchId) { (presentAtt) in
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
        topicVM.loadTopicsOfAid(aid: aid) { (topics, avgFeedback, covered) in
            topicVM.topicsOfSameAid = topics
        }
        //        topicVM.loadTopicsForAttendance(date: batchDateString, batchId: batch.batchId) { (topicArray, avgFeedback, coveredHrs) in
        //
        //        }
    }
    func unpairAndSetDefaultDeviceInformation() {
        // YOUR CODE IS HERE
        DispatchQueue.main.async {
            self.isShowingDetailView = 1
        }
    }
    var body: some View {
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
                            batchDate = $0.timeIntervalSince1970
                            let currentTimestamp = Date().timeIntervalSince1970
                            if currentTimestamp < batchDate {
                                showfutureToast = true
                                disableButton = true
                                return
                            }
                            let formate = $0.getFormattedDate(format: "dd MMM, yyyy") // Set output formate
                            batchDateString = formate
                            onCheck(selectedDate: formate)
                            
                        }
                }
            }
            
            
            List(DatabaseReference.shared.topicArray, id: \.id) { feedback in
                AddTopicRow(topicData: feedback)
            }
            
            VStack {
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: AddNewTopic(showModal: $showModal, batch: batch, batchDate: Int64(batchDate), batchDateString: batchDateString, rootIsActive: self.$rootIsActive, isActive: isActive)) {
                        HStack(spacing: 10) {
                            Text("+ click to add topic")
                                .frame(width: 177, height: 35)
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
            
            NavigationLink(destination:  MarkAttendance(newTopics: DatabaseReference.shared.topicArray, batch: batch, batchDateString: batchDateString, shouldPopToRootView: $isActive), tag: 1, selection: $isShowingDetailView) {
                EmptyView()
            }
            
            NavigationLink(destination: EmptyView(), label: {})
            
            Button(action: {
                if DatabaseReference.shared.topicArray.count == 0 {
                    showAtLeastToat = true
                    return
                }
                showingAlert = true
            }) {
                HStack(spacing: 10) {
                    Text("Next")
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.red)
            .disabled(disableButton == true)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Do you want to add more topics?"), message: Text("Once you mark attendance you unable to add more topics to this session"),  primaryButton: .destructive(Text("No")) {
                self.isShowingDetailView = 1
                let formate = date.getFormattedDate(format: "dd MMM, yyyy") // Set output formate
                batchDateString = formate
            },
            secondaryButton: .default(Text("Yes")) {
                
            })
        }
        .navigationTitle("Add Topic")
        .navigationBarTitleDisplayMode(.inline)
        .toast(isPresenting: $showToast, duration: 10.0){
            
            AlertToast(type: .regular, title: ToastAlert.attendanceMarked)
        }
        .toast(isPresenting: $showfutureToast, duration: 10.0){
            
            AlertToast(type: .regular, title: ToastAlert.FutureDate)
        }
        
        .toast(isPresenting: $showAtLeastToat, duration: 10.0){
            
            AlertToast(type: .regular, title: ToastAlert.AtLeastOne)
        }
    }
}

struct AddTopicRow: View {
    var topicData: Topic
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text(topicData.topic)
                Spacer()
                //                Button(action: {
                //                    print("Edit button was tapped")
                //                }) {
                //                    HStack(spacing: 10) {
                //                        Image("icn_threedots")
                //                    }
                //                }
            }
            Text(topicData.remarks)
            Text(topicData.timeSpent)
            
        }
        .padding(25)
        .border(Color("GrayColor"))
        .shadow(radius: 5 )
        
    }
}

