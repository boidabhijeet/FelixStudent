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
    
    init() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        navigationBarAppearace.tintColor = #colorLiteral(red: 0, green: 0.4377841353, blue: 0.654399991, alpha: 1)
        
    }
  
    
    var body: some View {
    

        List(batchVM.batches) { batch in
                BatchRow(batch: batch)
                    .shadow(color: Color.gray, radius: 5)
        }
        .onAppear() {
            
            if batchVM.batches.count > 0 {
                
            } else {
                if Utility.getRole() == Constants.FACULTY {
                    self.batchVM.subscribe(facultyUid: Auth.auth().currentUser!.uid)
                } else if Utility.getRole() == Constants.STUDENT {
                    self.batchVM.getBatchForStudent()
                }
            }
        }
        .listStyle(InsetListStyle())
        .navigationTitle("Felix Student")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    print("Notification icon tap")
//                    let myDate = Date()
//                }, label: { Image("icn_notification")
//
//                })
                NavigationLink(destination: NotificationView()) {
                    Image("icn_notification")
                }
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
                            .font(.system(size: 25, weight: .bold, design: .default))
                        Spacer()
                        if Utility.getRole() == Constants.FACULTY {
                            Text("start date: \(batch.fromDateString) @\(batch.fromTime)")
                        } else {
                            Text("Batch start date: \(batch.fromDateString)")
                        }
                        Spacer()
                        if Utility.getRole() == Constants.FACULTY {
                            Text("Hours Covered: \(batch.totalHours)")
                            Spacer()
                            Text("Total Students: \(batch.students.count)")
                            Spacer()
                        } else {
                            Text(batch.fromToTime)
                            Spacer()
                            Text("Faculty Name: \(batch.faculty)")
                            Spacer()
                        }
                        
                        
                    })
                    .padding(25)
                    
                }
            }
            
        }
        .isDetailLink(false)
    }
}
