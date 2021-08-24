//
//  AddNewTopic.swift
//  Felix Student
//
//  Created by Mac on 16/04/21.
//

import SwiftUI
import AlertToast

struct AddNewTopic: View {
    @State private var isExpanded = false
    @State  private var topic = ""
    @State  private var note = ""
    @Binding var showModal: Bool
    @State private var time = 0.0
    var screenSize = UIScreen.main.bounds
    var batch: Batch
    var batchDate: Int64
    var batchDateString: String
    @State var futureTopic = Topic()
    @State private var showToast = false
    @Binding var rootIsActive : Bool
    @State var isActive : Bool
    @Environment(\.presentationMode) var presentationMode
//    @State private var timeSpentInHrs : Double = 0
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
        ZStack {
            
            //            Color(.black).edgesIgnoringSafeArea(.all).opacity(0.8)
            
            VStack(alignment : .leading) {
                
                Text("Add New Topic")
                    .font(.system(size: 18, weight: .semibold, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 5, y : 6)
                
                Spacer().frame(maxHeight : 40)
                        
                Text("Add topic and Time spent on it")
                    .font(.system(size: 15))
                
                Spacer().frame(maxHeight : 20)
                
                Group{
                    
                    Spacer().frame(maxHeight : 20)

                    TextField("Topic", text: $topic)
                    
                    Divider().background(Color.black)
                    
                    Spacer().frame(maxHeight : 20)

                    TextField("Note (Optional)", text: $note)
                    
                    Divider().background(Color.black)
                    
                    HStack{
                        Text("Time Spent")
                        Spacer()
                        Text("\(selection.joined(separator: ".")) Hrs")
//                        Text("\(timeSpentInHrs, specifier: "%.2f") Hrs")
                    }
                    .padding(.top, 20)
                    
                }
                .font(.system(size: 15))
                
                
//                Slider(value: $timeSpentInHrs, in: 1...10, step : 0.1)
//                    .accentColor(.red)

                
                MultiPicker(data: data, selection: $selection).frame(height: 300)
                
                Text("Note* : Time cannot change once you add.")
                    .font(.system(size: 12))
                
                Spacer().frame(maxHeight : 40)
                
                HStack{
                    Spacer()
                    
                    Button("CANCEL"){
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Button {
//                        if topic == "" ||  Double(selection.joined(separator: ".")) == 0.0 {
                        if topic == "" {
                            showToast = true
                        } else {
                            futureTopic = Topic(aid: "", batchId: batch.batchId, batchModule: batch.module, date: batchDateString, dateCreatedAt: batchDate, remarks: note, timeSpent: "\(selection.joined(separator: "."))", timespentmints: calculateTimeSpentMins(), topic: topic)
                            showModal = false
                            DatabaseReference.shared.topicArray.append(futureTopic)
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("OK")
                    }
                }
                .padding(.bottom)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.red)
                
                Spacer()
                
            }
            .padding()
            .frame(width: screenSize.width * 0.9, height: screenSize.height * 0.9)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            //            .offset(y: isPresented ? 0 : screenSize.height)
            .animation(.spring())
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
