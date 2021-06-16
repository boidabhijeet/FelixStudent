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
    var batchDate: Int64
    //    var topicData: Topic
    var batchDateString: String
    @State var futureTopic = Topic()
    @State private var showToast = false
    @Binding var rootIsActive : Bool
    @State var isActive : Bool
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @State var selection: [String] = [0, 00].map { "\($0)" }
    @State var data: [(String, [String])] = [
        ("One", Array(0...8).map { "\($0)" }),
        ("Two", Array(arrayLiteral: "00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55").map { "\($0)" })
    ]
    
    func calculateTimeSpentMins() -> Int {
        let x = Int(selection[0])! * 60
        let y = x + Int(selection[1])!
        return y
    }
    var body: some View {
        ScrollView {
            VStack {
                
                Text("Add topic and Time spent on it")
                TextField("Topic", text: $topic)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("Note (Optional)", text: $note)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                HStack {
                    Text("Time spent")
                    Text("\(selection.joined(separator: ".")) Hrs")
                }.padding()
                //            Text(verbatim: "Selection: \(selection.joined(separator: "."))")
                MultiPicker(data: data, selection: $selection).frame(height: 300)
                Text("Note*: Time cannot change once you add.")
                
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(spacing: 10) {
                            Text("Cancel")
                        }
                    }.padding(10)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.red)
                    
                    Button(action: {
                        if topic == "" ||  Double(selection.joined(separator: ".")) == 0.0 {
                            showToast = true
                        } else {
                            futureTopic = Topic(aid: "", batchId: batch.batchId, batchModule: batch.module, date: batchDateString, dateCreatedAt: batchDate, remarks: note, timeSpent: "\(selection.joined(separator: ".")) Hrs", timespentmints: calculateTimeSpentMins(), topic: topic)
                            showModal = false
                            DatabaseReference.shared.topicArray.append(futureTopic)
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(spacing: 10) {
                            Text("Ok")
                        }.padding(10)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.red)
                    }
                }
            }
        }
    }
}

struct MultiPicker: View  {
    
    typealias Label = String
    typealias Entry = String
    
    let data: [ (Label, [Entry]) ]
    @Binding var selection: [Entry]
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(0..<self.data.count) { column in
                    Picker(self.data[column].0, selection: self.$selection[column]) {
                        ForEach(0..<self.data[column].1.count) { row in
                            Text(verbatim: self.data[column].1[row])
                                .tag(self.data[column].1[row])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / CGFloat(self.data.count), height: geometry.size.height)
                    .clipped()
                }
            }
        }
    }
}
