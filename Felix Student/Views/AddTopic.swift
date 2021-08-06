//
//  AddTopic.swift
//  Felix Student
//
//  Created by Mac on 16/04/21.

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
    @Environment(\.presentationMode) var presentationMode
    @State private var showToast = false
    @State private var showfutureToast = false
    @State private var showAtLeastToat = false
    @State private var disableButton = false
    @State private var showingAlert = false
    @State private var isShowingDetailView: Int? = 0
    @State private var isPresented : Bool = false
    
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
        ZStack {
            VStack(alignment: .leading){
                Group{
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack{
                            Image(systemName: "arrow.left")
                            Text("Add Topic")
                        }
                        .foregroundColor(.black)
                    })
                    .padding(.horizontal)
                                        
                    Divider()
                    
                    Spacer().frame(maxHeight : 20)
                    
                    HStack() {
                        
                        Text("Batch Date :")
                            .fontWeight(.semibold)
                        Text(stringDate())
                            .onAppear {
                                onLoad()
                            }
                        
                        Spacer()
                        
                        DatePicker("", selection: $date, displayedComponents: [.date])
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
                    }.padding(.horizontal)
                    
                    Spacer().frame(maxHeight : 20)
                    
                    
                    List(DatabaseReference.shared.topicArray, id: \.id) { feedback in
                        AddTopicRow(item: feedback)
                    }
                    .listStyle(PlainListStyle())
                    
                    HStack{
                        
                        Spacer()
                        
                        HStack(spacing : 2){
                            Image(systemName : "plus")
                                .foregroundColor(.red)
                            
                            Button("Click To Add Topic") {
                                isPresented.toggle()
                            }
                            .sheet(isPresented: $isPresented) {
                                // MARK: FIX ME
                                //                                AddNewTopicAlert(isPresented: $showingAlert)
                                AddNewTopic(showModal: $showModal, batch: batch, batchDate: Int64(batchDate), batchDateString: batchDateString, rootIsActive: self.$rootIsActive, isActive: isActive)
                                
                            }
                        }
                        .font(.system(size: 13, weight: .semibold))
                        .frame(maxWidth: 165, maxHeight: 40)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .clipped()
                        .shadow(color: .gray, radius : 5)
                    }
                    .padding(.horizontal)
                    
                    
                    Spacer().frame(maxHeight : 20)
                    
                    NavigationLink(destination:  MarkAttendance(newTopics: DatabaseReference.shared.topicArray, batch: batch, batchDateString: batchDateString, shouldPopToRootView: $isActive)                              .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true), tag: 1, selection: $isShowingDetailView) {
                        EmptyView()
                    }
                    NavigationLink(destination: EmptyView(), label: {})
                }
                
                Button(action: {
                    if DatabaseReference.shared.topicArray.count == 0 {
                        showAtLeastToat = true
                        return
                    }
                    showingAlert = true
                }) {
                    Text("Next")
                }
                .font(.system(size: 24, weight: .semibold))
                .frame(maxWidth: .infinity, maxHeight: 65, alignment: .center)
                .background(Color.red)
                .foregroundColor(.white)
                .disabled(disableButton == true)
            }
            .edgesIgnoringSafeArea(.bottom)
            .blur(radius: showingAlert ? 2 : 0)
            .toast(isPresenting: $showToast, duration: 3.0){
                AlertToast(type: .regular, title: ToastAlert.attendanceMarked)
            }
            .toast(isPresenting: $showfutureToast, duration: 3.0){
                AlertToast(type: .regular, title: ToastAlert.FutureDate)
            }
            .toast(isPresenting: $showAtLeastToat, duration: 3.0){
                AlertToast(type: .regular, title: ToastAlert.AtLeastOne)
            }
            
            //Added to avoid the automatic dismiss of View as there some bug in current version.
            NavigationLink(destination: EmptyView(), label: {})
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Do you want to add more topics?"), message: Text("Once you mark attendance you unable to add more topics to this session"),
                  primaryButton: .destructive(Text("No")) {
                    self.isShowingDetailView = 1
                    let formate = date.getFormattedDate(format: "dd MMM, yyyy") // Set output formate
                    batchDateString = formate
                  },
                  secondaryButton: .default(Text("Yes")) {
                    //Code
                  })
        }
    }
}


struct AddTopicRow: View {
    var item: Topic
    var body: some View {
        
        HStack{
            VStack(alignment :.leading, spacing : 10) {
                Text(item.topic)
                Text(item.remarks)
                Text(item.timeSpent + "Hrs")
//                Text("\(Int(item.timeSpent) ?? 0, specifier: "%.2f") Hrs")

            }
            .font(.system(size: 15))
            
            Spacer()
            
            Menu {
                Button(action: {}) {
                    Label("Edit", systemImage: "pencil")
                }
                
                Button(action: {}) {
                    Label("Delete", systemImage: "trash.fill")
                }
            }
            label: {
                Image("verticalDots")
            }
        }
        .padding()
        .modifier(GrayShadow())
    }
}
