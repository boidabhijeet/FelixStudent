//
//  BatchDetails.swift
//  Felix Student
//
//  Created by Mac on 14/04/21.
//

import SwiftUI

struct BatchDetails: View {
    
    var batch: Batch
    @State var didAppear = false
    @State var appearCount = 0
    @State private var timeSpent = ""
    @ObservedObject var topicVM = TopicViewModel()
    @State var avgFeedback = 0
    @State private var isActive : Bool = false
    @Environment(\.presentationMode) var presentationMode
    var screenSize = UIScreen.main.bounds
    @State var hrsCovered = ""
    func onLoad() {
        if !didAppear || Utility.fromFeedbackScreen {
            appearCount += 1
            topicVM.loadTopicsWith(batchId: batch.batchId){ (topics,avgFeedback,hrsCovered)  in
                self.avgFeedback = avgFeedback
                self.hrsCovered = hrsCovered
                Utility.fromFeedbackScreen = false
            }
        }
        didAppear = true
    }
    var body: some View {
        
        ZStack(alignment : .bottomTrailing) {
            VStack{
                Button(
                    action: {self.presentationMode.wrappedValue.dismiss()},
                    label: {
                        HStack{
                            Image(systemName: "arrow.left")
                            Text("Batch Details")
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth : .infinity, alignment : .leading)
                        .padding(.leading, 15.0)
                    })
                
                Divider()
                
                HStack(spacing : 0){
                    Image("\(batch.module)Bar")
                    
                    VStack(spacing : 10){
                        HStack{
                            VStack(alignment :.leading, spacing : 12) {
                                Text(batch.module)
                                    .textCase(.uppercase)
                                    .modifier(TextStyle20())
                                
                                if Utility.getRole() == Constants.FACULTY {
                                    Text("Start date: \(batch.fromDateString) @\(batch.fromTime)")
                                } else {
                                    Text("Batch Start Date: \(batch.fromDateString)")
                                }
                                Text("Hours Covered: \(batch.totalHours)")
                                if Utility.getRole() == Constants.FACULTY {
                                    Text("Total Students: \(batch.students.count)")
                                }
                            }
                            .modifier(TextStyle14())
                            .lineLimit(0)
                            .padding(.top, 10)
                            
                            
                            Spacer()
                            
                            Image(batch.module)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 63, height: 63)
                        }
                        NavigationLink(
                            destination : DisplayStudyMaterial()
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true),
                            label: {
                                Text("Show study material")
                                    .modifier(TextStyle14())
                                    .foregroundColor(.red)
                                    .lineLimit(0)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment : .trailing)
                                
                                Image("rightArrowRed")
                            })
                            .padding(.bottom, 12)
                        
                    }
                    .padding()
                    .frame(maxWidth : screenSize.width * 0.9, minHeight : screenSize.height * 0.19, maxHeight : screenSize.height * 0.20, alignment: .center)
                    .background(Color.white)
                    .clipped()
                    .shadow(radius : 5)
                }.padding(.vertical, 5)
                
                
                Text("Topics Covered")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth : screenSize.width * 0.9, alignment: .leading)
                    .padding(.top)
                
                
                listView
                    .onAppear(perform: {
                        onLoad()
                    })
            }
            
            if Utility.getRole() == Constants.FACULTY {
                Spacer()
                NavigationLink(destination:
                                AddTopic(batch: batch, fromPlusButton: true, aid: "", batchDateString: "", isActive: isActive, rootIsActive: self.$isActive)
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true))
                {
                    Image("addTopicIcon").padding()
                }
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
            }
        }
        //        .navigationBarHidden(true)
    }
    @ViewBuilder
    var listView: some View {
        if topicVM.topics.isEmpty {
            emptyListView
        } else {
            objectsListView
        }
    }
    
    var emptyListView: some View {
        VStack{
            Spacer()
            Text("No topics covered yet.")
            Spacer()
        }
    }
    
    var objectsListView: some View {
        List(topicVM.topics) { topic in
            TopicRow(topicData: topic, batch: batch)
                .listRowBackground(Color.red)
        }
    }
}

struct TopicRow: View {
    @State var topicData: Topic
    var screenSize = UIScreen.main.bounds
    
    var batch: Batch
    let role = Utility.getRole()
    //    @State var isActive : Bool = false
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            
            //                topicData.sort({$0.date.timeIntervalSinceNow > $1.date.timeIntervalSinceNow})
            HStack(alignment : .top) {
                
                VStack(alignment : .leading, spacing : 5){
                    
                    Text(topicData.topic)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("Hours: " + topicData.timeSpent)
                        .font(.system(size: 12))
                    
                    
//                    Spacer().frame(maxHeight : 20)
                    
                    if role == Constants.FACULTY {
                        HStack(spacing : 1) {
                            
                            if topicData.averageFeedback == 0 {
                                Text("Avg rating: \(topicData.averageFeedback)")
                                    .font(.system(size: 12))
                                
                            } else if topicData.averageFeedback == 3 {
                                HStack(spacing : 1) {
                                    Text("Avg rating: ")
                                        .font(.system(size: 12))
                                    
                                    Image("understood")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    
                                }
                                
                            } else if topicData.averageFeedback == 2 {
                                HStack(spacing : 1) {
                                    Text("Avg rating: ")
                                        .font(.system(size: 12))
                                    
                                    Image("partiallyUnderstood")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    
                                }
                            } else if topicData.averageFeedback == 1 {
                                HStack(spacing : 1) {
                                    Text("Avg rating: ")
                                        .font(.system(size: 12))
                                    
                                    Image("notUnderstoodRed")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    
                                }
                            }
                            Spacer()
                            
                        }
                    } else {
                        //                HStack(spacing : nil){
                        HStack {
                            if topicData.rating == 0 {
                                Text("My rating: 0")
                                    .font(.system(size: 12))
                                
                            } else if topicData.rating == 3 {
                                HStack(spacing : 1) {
                                    Text("My rating: ")
                                        .font(.system(size: 12))
                                    
                                    Image("understood")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    Spacer()
                                }
                                
                            } else if topicData.rating == 2 {
                                HStack(spacing : 1) {
                                    Text("My rating: ")
                                        .font(.system(size: 12))
                                    
                                    Image("partiallyUnderstood")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    
                                    Spacer()
                                }
                            } else if topicData.rating == 1 {
                                HStack(spacing : 1) {
                                    Text("My rating: ")
                                        .font(.system(size: 12))
                                    
                                    Image("notUnderstoodRed")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                
                VStack(alignment : .trailing){
                    Text(topicData.date)
                        .font(.system(size: 12, weight: .semibold))
                    Text(topicData.presentString)
                        .font(.system(size: 12))
                        .padding(.top, 2)
                }
            }
            .padding()
            .frame(maxWidth : screenSize.width * 0.9)
            .modifier(GrayShadow())

            
            if Utility.getRole() == Constants.FACULTY {
                NavigationLink(destination:
                                StudentFeedback(topic: topicData, avgFeedback: 0)
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                ) {
                    EmptyView()
                }
            } else if Utility.getRole() == Constants.STUDENT && topicData.presentString == "Feedback pending" {
                NavigationLink(
                    destination: GiveFeedback(topic: topicData)
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true))
                {
                    HStack{
                        Spacer()
                        Image("feedbackPending").padding()
                    }
                }
            } else if Utility.getRole() == Constants.STUDENT && topicData.presentString == "Feedback sent" {
                NavigationLink(
                    destination: Feedback(topic: topicData)
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true))
                {
                    HStack{
                        Spacer()
                        Image("feedbackSent").padding()
                    }
                }
            } else {
                HStack{
                    Spacer()
                    Image("absent").padding()
                }
            }
        }
        //        Spacer()
    }
}

struct CustomListView: View {
    @StateObject var model = VM()
    var batch: Batch
    var body: some View {
        return UIListView(reload: $model.reload, items: $model.items, batchDetails: $model.batchDetails)
            .onAppear {
                model.batch = batch
                model.fetchData()
            }
    }
}

// MARK:- Data

class VM: ObservableObject {
    
    @Published var reload = false
    var items = [Attendance]()
    var batch: Batch?
    var topicVM = TopicViewModel()
    var topics = [Topic]()
    var batchDetails = [String: [Topic]]()
    
    func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.topicVM.loadAttendanceWith(batchId: self.batch!.batchId) { (attArr) in
                self.items = attArr
                for att in attArr {
                    self.topicVM.loadTopicsOfAid(aid: att.aid) { (topics,avgFeedback,hrsCovered)  in
                        print("aid = \(att.aid)")
                        self.batch?.totalHours = hrsCovered
                        self.batchDetails.updateValue(topics, forKey: att.aid)
                        self.reload.toggle()
                    }
                }
            }
        }
    }
}

struct UIListView: UIViewRepresentable {
    
    @Binding var reload: Bool
    @Binding var items: [Attendance]
    @Binding var batchDetails: [String: [Topic]]
    
    func makeUIView(context: Context) -> UITableView {
        let tableView =  UITableView()
        tableView.dataSource = context.coordinator
        return tableView
    }
    
    func updateUIView(_ tableView: UITableView, context: Context) {
        if reload {
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension UIListView {
    
    final class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        
        private var parent: UIListView
        var batchDetailTableView = UITableView()
        
        init(_ parent: UIListView) {
            self.parent = parent
            super.init()
            batchDetailTableView.register(BatchDetailTableViewCell.self, forCellReuseIdentifier: "cell")
            batchDetailTableView.delegate = self
            batchDetailTableView.dataSource = self
            batchDetailTableView.rowHeight = UITableView.automaticDimension
            batchDetailTableView.estimatedRowHeight = UITableView.automaticDimension
            
        }
        
        //MARK: UITableViewDataSource Methods
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return parent.items.count
        }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return parent.items[section].aid
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return parent.batchDetails[parent.items[section].aid]!.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            print("*********Cell for row at")
            tableView.register(BatchDetailTableViewCell.self, forCellReuseIdentifier: "cell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatchDetailTableViewCell
            cell.backgroundColor = .blue
            cell.labUserName.text = "Name"
            cell.labMessage.text = "Message \(indexPath.row)"
            cell.labTime.text = "13 March 2021"
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    }
}
