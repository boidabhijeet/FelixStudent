//
//  MarkAttendance.swift
//  Felix Student
//
//  Created by Mac on 16/04/21.
//

import SwiftUI

struct MarkAttendance: View {
    @State var checklistItems: [ChecklistItem] = []
    var newTopics: [Topic]
    var studentVM = StudentViewModel()
    var batch: Batch
    var topicVM = TopicViewModel()
    var batchDateString: String
    @Binding var shouldPopToRootView : Bool
    @State var isActive : Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading){
            
            //Added to avoid the automatic dismiss of View as there some bug in current version.
            NavigationLink(destination: EmptyView(), label: {})


            Text("Mark Attendance")
                .padding(.horizontal)
            
            Divider()
            
            List(checklistItems) { checklistItem in
                HStack{
                    Image("personCircle")
                    
                    Text(checklistItem.name)
                    
                    Spacer()
                    
                    if(checklistItem.isChecked){
                        Image(systemName: "checkmark.square.fill")
                            .foregroundColor(.red)
                    }else{
                        Image(systemName: "square")
                            .foregroundColor(.red)
                    }
                }
                .padding(10)
                .modifier(GrayShadow())
                .onTapGesture {
                    if let matchingIndex = self.checklistItems.firstIndex(where: { $0.id == checklistItem.id }) {
                        self.checklistItems[matchingIndex].isChecked.toggle()
                    }
                }
            }
            .listStyle(PlainListStyle())
            .onAppear(perform: {
                studentVM.getStudentsFom(batchId: batch.batchId) { (studArray) in
                    checklistItems = []
                    for stud in studArray {
                        checklistItems.append(ChecklistItem(name: stud.name, uid: stud.leadId))
                    }
                }
            })
            
            Spacer()
          
            Button("Mark Attendance") {
                var markAtt = [String: Bool]()
                for item in checklistItems {
                    markAtt.updateValue(item.isChecked, forKey: item.uid)
                }
                self.shouldPopToRootView = true
                for newTopic in newTopics {
                    let att = Attendance(batchId: batch.batchId, batchModule: batch.module, remark: newTopic.remarks, totalTimeSpent: newTopic.timeSpent, totalTimeSpentMints: newTopic.timeSpentMints, markAttendance: markAtt, createdAt: Int64(Date().timeIntervalSince1970))
                    //                    print(att.toJSON())
                    newTopic.date = batchDateString
                    topicVM.saveAttendanceAndTopic(newTopic: newTopic, attn: att)
                    DatabaseReference.shared.topicArray = []
                }

//                NavigationView{
                    Router.showTabbar()
//                }
            }
            .font(.system(size: 24, weight: .semibold))
            .frame(maxWidth: .infinity, minHeight: 65, alignment: .center)
            .background(Color.red)
            .foregroundColor(.white)
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    func deleteListItem(whichElement: IndexSet) {
        checklistItems.remove(atOffsets: whichElement)
    }

    func moveListItem(whichElement: IndexSet, destination: Int) {
        checklistItems.move(fromOffsets: whichElement, toOffset: destination)
    }

}

struct ChecklistItem: Identifiable {
    let id = UUID()
    var name: String
    var isChecked: Bool = false
    var uid: String
}
