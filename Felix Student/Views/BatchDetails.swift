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
    
    @State var hrsCovered = ""
    func onLoad() {
        UINavigationBar.appearance().tintColor = .systemGray6
        UINavigationBar.appearance().barTintColor = .systemTeal
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)]
        // Set selected (onTapped) background color of cell.
        let color = UIView()
        color.backgroundColor = UIColor.red
        UITableViewCell.appearance().selectedBackgroundView = color
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
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white)
                    .frame(width: 350, height: 130)
                
                VStack(alignment: .leading) {
                    Text(batch.module)
                        .font(.system(size: 20, weight: .regular, design: .default))
                    if Utility.getRole() == Constants.FACULTY {
                        Text("Start date: \(batch.fromDateString) @\(batch.fromTime)")
                    } else {
                        Text("Batch start date: \(batch.fromDateString)")
                    }
                    
                    Text("Hours Covered: \(self.hrsCovered)")
                    
                    if Utility.getRole() == Constants.FACULTY {
                        Text("Total Students: \(batch.students.count)")
                    } else {
                        Text("Faculty Name: \(batch.faculty)")
                    }
                    
                }
                .padding()
                .modifier(TextStyle14())

            }
            .padding()
            .shadow(color: Color.gray, radius: 5)
            
            Section(header:
                        Text("Topics Covered")
                        .fontWeight(.heavy)
            ) {
            }.foregroundColor(.black)
            
            
            listView
                .onAppear(perform: {
                    onLoad()
                })
//                .listStyle(InsetListStyle())
//                .listItemTint(.black)
                
            
            if Utility.getRole() == Constants.FACULTY {
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: AddTopic(batch: batch, aid: "", fromPlusButton: true, topic: nil, rootIsActive: self.$isActive, batchDateString: "", isActive: isActive)) {
                            HStack(spacing: 10) {
                                Text("+")
                                    .font(.system(.largeTitle))
                                    .frame(width: 57, height: 50)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 7)
                            }
                            
                        }
                        .isDetailLink(false)
                        .background(Color.black)
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                    }
                }
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .navigationBarTitle("Batch Details")
        .navigationBarTitleDisplayMode(.inline)
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
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
            
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text(topicData.topic).font(.system(size: 16, weight: .bold, design: .default))
                    Spacer()
                    Text(topicData.date)
                }
                Spacer()
                Text("Hours: " + topicData.timeSpent)
                Spacer()
                if role == Constants.FACULTY {
                    HStack {
                        
                        if topicData.averageFeedback == 0 {
                            Text("Avg rating:\(topicData.averageFeedback)")
                        } else if topicData.averageFeedback == 3 {
                            HStack {
                                Text("Avg rating: ")
                                Image("icn_understoodselected")
                            }
                            
                        } else if topicData.averageFeedback == 2 {
                            HStack {
                                Text("Avg rating: ")
                                Image("icn_partiallyunderstood-1")
                            }
                        } else if topicData.averageFeedback == 1 {
                            HStack {
                                Text("Avg rating: ")
                                Image("icn_notunderstoodselected")
                            }
                            Spacer()
                            Text(topicData.presentString)
                        }
                    }
                } else {
                    HStack {
                        if topicData.rating == 0 {
                            Text("My rating: 0")
                        } else if topicData.rating == 3 {
                            HStack {
                                Text("My rating: ")
                                Image("icn_understoodselected")
                            }
                            
                        } else if topicData.rating == 2 {
                            HStack {
                                Text("My rating: ")
                                Image("icn_partiallyunderstood-1")
                            }
                        } else if topicData.rating == 1 {
                            HStack {
                                Text("My rating: ")
                                Image("icn_notunderstoodselected")
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
        }.padding()
        .shadow(color: Color.gray, radius: 5)
        
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

