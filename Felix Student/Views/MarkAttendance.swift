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
    @Binding var shouldPopToRootView : Bool
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
//    let navigationStack: NavigationStack
    
    @State var isActive : Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    var body: some View {
//        NavigationView {
        VStack {
            List (checklistItems) { checklistItem in
                HStack {
                    Image("icn_smallPlaceholder")
                    Text(checklistItem.name)
                    Spacer()
                    
                        Text(checklistItem.isChecked ? "✅" : "🔲")
                    
                    
                }
                .onTapGesture {
                  if let matchingIndex = self.checklistItems.firstIndex(where: { $0.id == checklistItem.id }) {
                    self.checklistItems[matchingIndex].isChecked.toggle()
                  }
                }

                
                //              .onDelete(perform: deleteListItem)
                //              .onMove(perform: moveListItem)
            }.onAppear(perform: {
                studentVM.getStudentsFom(batchId: batch.batchId) { (studArray) in
                    checklistItems = []
                    for stud in studArray {
                        checklistItems.append(ChecklistItem(name: stud.name, uid: stud.leadId))
                    }
                    print(checklistItems)
                }
            })
            .navigationBarItems(trailing: EditButton())
            .navigationBarTitle("Mark Attendance")
            Button(action: {
                var markAtt = [String: Bool]()
                for item in checklistItems {
                    markAtt.updateValue(item.isChecked, forKey: item.uid)
                }
                self.shouldPopToRootView = true
                Router.showTabbar()

//                let att = Attendance(batchId: batch.batchId, batchModule: batch.module, remark: newTopic.remarks, totalTimeSpent: newTopic.timeSpent, totalTimeSpentMints: newTopic.timeSpentMints, markAttendance: markAtt, createdAt: Int64(Date().timeIntervalSince1970))
//                print(att.toJSON())
//                topicVM.saveAttendanceAndTopic(newTopic: newTopic, attn: att)
//                self.mode.wrappedValue.dismiss()
//                self.rootPresentationMode.wrappedValue.dismiss()
//                self.presentationMode.wrappedValue.dismiss()
//                navigationStack.pop(to: .root)
            }) {
                HStack(spacing: 10) {
                    Text("Mark Attendance")
                }
            }.padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.red)
        }.navigationTitle("Mark Attendance")
//        }
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
