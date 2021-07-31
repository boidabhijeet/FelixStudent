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
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
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
                            
                            
                            VStack(alignment :.leading, spacing : 10) {
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
                            
                            Spacer()
                            
                            Image(batch.module)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 63, height: 63)
                                .padding(.bottom)
                                .padding(.horizontal)
                        }
                        NavigationLink(
                            destination : Text("Display Study Material"),
                            label: {
                                Text("Show study material")
                                    .modifier(TextStyle14())
                                    .foregroundColor(.red)
                                    .lineLimit(0)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment : .trailing)
                                
                                Image("rightArrowRed")
                            })
                    }
                    .padding()
                    .frame(maxWidth : screenSize.width * 0.9, maxHeight : screenSize.height * 0.16, alignment: .center)
                    .background(Color.white)
                    .clipped()
                    .shadow(radius : 5)
                }.padding(.top, 10)
                
                
                Text("Topics Covered")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth : screenSize.width * 0.9, alignment: .leading)
                    .padding(.top)
                
                
                listView
                    .onAppear(perform: {
                        onLoad()
                    })
                //                .listStyle(InsetListStyle())
                //                .listItemTint(.black)
                
            }
            
            if Utility.getRole() == Constants.FACULTY {
                Spacer()
                
                NavigationLink(destination:
                                AddTopic(batch: batch, aid: "", fromPlusButton: true, topic: nil, rootIsActive: self.$isActive, batchDateString: "", isActive: isActive)
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true))
                {
                    Image("addTopicIcon").padding()
                }
            }
        }
        .navigationBarHidden(true)
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
        Text("No topic covered yet.")
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
    var batch: Batch
    let role = Utility.getRole()
    @State var isActive : Bool = false
    var body: some View {
        ZStack(alignment : .bottomTrailing) {
            VStack(alignment : .leading){
                HStack {
                    Text(topicData.topic)
                        .font(.system(size: 14, weight: .semibold))
                    Spacer()
                    Text(topicData.date)
                        .font(.system(size: 12))
                }
                
                Text("Hours: " + topicData.timeSpent)
                    .font(.system(size: 12))
                
                Spacer().frame(maxHeight : 20)
                
                if role == Constants.FACULTY {
                    HStack(spacing : 1) {
                        
                        if topicData.averageFeedback == 0 {
                            Text("My rating:\(topicData.averageFeedback)")
                                .font(.system(size: 12))
                            
                        } else if topicData.averageFeedback == 3 {
                            HStack {
                                Text("My rating: ")
                                    .font(.system(size: 12))
                                
                                Image("understood")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                            }
                            
                        } else if topicData.averageFeedback == 2 {
                            HStack {
                                Text("My rating: ")
                                Image("partiallyUnderstood")
                            }
                        } else if topicData.averageFeedback == 1 {
                            HStack {
                                Text("My rating: ")
                                Image("notUnderstoodRed")
                            }
                            Spacer()
                            Text(topicData.presentString)
                        }
                    }
                } else {
                    HStack {
                        if topicData.rating == 0 {
                            Text("My rating: 0")
                                .font(.system(size: 12))
                            
                        } else if topicData.rating == 3 {
                            HStack {
                                Text("My rating: ")
                                    .font(.system(size: 12))
                                
                                Image("understood")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                            }
                            
                        } else if topicData.rating == 2 {
                            HStack {
                                Text("My rating: ")
                                    .font(.system(size: 12))
                                
                                Image("partiallyUnderstood")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                            }
                        } else if topicData.rating == 1 {
                            HStack {
                                Text("My rating: ")
                                    .font(.system(size: 12))
                                
                                Image("notUnderstoodRed")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                            }
                        }
                        
                        Spacer()
                        
                        if topicData.presentString == "Feedback sent" {
                            Group {
                                Text(topicData.presentString)
                            }.padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.green, lineWidth: 2)
                            )
                            .background(Color.green)
                            .opacity(0.5)
                        } else if topicData.presentString == "Feedback pending" {
                            Group {
                                Text(topicData.presentString)
                            }.padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.yellow, lineWidth: 2)
                            )
                            .background(Color.yellow)
                            .opacity(0.5)
                        } else {
                            Group {
                                Text(topicData.presentString)
                            }.padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                            .background(Color.red)
                            .opacity(0.5)
                        }
                    }
                }
                if Utility.getRole() == Constants.FACULTY {
                    NavigationLink(destination: StudentFeedback(topic: topicData, avgFeedback: 0)) {
                        EmptyView()
                    } .isDetailLink(false)
                    .buttonStyle(PlainButtonStyle()).frame(width:0).opacity(0)
                } else if Utility.getRole() == Constants.STUDENT && topicData.presentString == "Feedback pending" {
                    
                    NavigationLink(destination: GiveFeedback(topic: topicData)) {
                        EmptyView()
                    } .isDetailLink(false)
                    .buttonStyle(PlainButtonStyle()).frame(width:0).opacity(0)
                } else if Utility.getRole() == Constants.STUDENT && topicData.presentString == "Feedback sent" {
                    NavigationLink(destination: Feedback(topic: topicData)) {
                        EmptyView()
                    }.isDetailLink(false)
                    .buttonStyle(PlainButtonStyle()).frame(width:0).opacity(0)
                }
            }.padding()
        }
    }
}


struct CustomListView: View {
    @StateObject var model = VM()
    var batch: Batch
    var body: some View {
        print("******* BODY")
        return UIListView(reload: $model.reload, items: $model.items, batchDetails: $model.batchDetails)
            .onAppear {
                model.batch = batch
                model.fetchData()
            }
    }
}

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
        print("*************** make")
        let tableView =  UITableView()
        tableView.dataSource = context.coordinator
        return tableView
    }
    
    func updateUIView(_ tableView: UITableView, context: Context) {
        print("*************** update", items.count)
        print("********* RELOAD", reload)
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
