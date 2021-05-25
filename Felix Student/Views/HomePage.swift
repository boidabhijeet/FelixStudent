//
//  HomePage.swift
//  Felix Student
//
//  Created by Mac on 14/04/21.
//

import SwiftUI
import FirebaseAuth

struct HomePage: View {
    @StateObject var batchVM = BatchViewModel()
    
    var body: some View {
        List(batchVM.batches) { batch in
//            ForEach { batch in
                
                BatchRow(batch: batch)
                    .shadow(color: Color.gray, radius: 10)
//            }
        }
        .onAppear() {
            if Utility.getRole() == Constants.FACULTY {
                self.batchVM.subscribe(facultyUid: Auth.auth().currentUser!.uid)
            } else if Utility.getRole() == Constants.STUDENT {
                self.batchVM.getBatchForStudent()
            }
            
        }
        .listStyle(InsetListStyle())
        .navigationTitle("Felix Student")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    print("Notification icon tap")
                    let myDate = Date()
                }, label: { Image("icn_notification")
                    
                })
            }
        }
        
    }
}
struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

struct BatchRow: View {
    var batch: Batch
    
    @State private var isActive : Bool = false
    var body: some View {
        NavigationLink(destination: BatchDetails(batch: batch), isActive: $isActive) {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white)
                HStack {
                    
                    VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                        Spacer()
                        Text(verbatim: batch.module)
                            .font(.headline)
                        Spacer()
                        Text("start date: \(batch.fromDateString) @\(batch.fromTime)")
                        Spacer()
                        Text("Hours Covered: \(batch.totalHours)")
                        Spacer()
                        Text("Total Students: \(batch.students.count)")
                        Spacer()
                    })
                    .padding(25)
                    
                }
            }
            
        }
        .isDetailLink(false)
    }
}
