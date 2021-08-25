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
    @StateObject var notificationVM = NotificationViewModel()
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Felix Student")
                Spacer()
                NavigationLink(
                    destination: NotificationView()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true),
                    label: {
                        if notificationVM.notifications.count == 0{
                            Image(systemName : "bell")
                                .foregroundColor(.black)
                        }else{
                            Image(systemName : "bell")
                                .foregroundColor(.black)
                                .overlay(
                                    Color.red.clipShape(Circle())
                                        .frame(width: 11, height: 11)
                                        .offset(x: 7, y: -5)
                                )
                        }
                    })
            }
            .padding()
            .modifier(TextStyle20())
            
            List(batchVM.batches) { batch in
                BatchRow(batch: batch)
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
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .modifier(TextStyle20())
        }
        .navigationBarHidden(true)
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
        
        ZStack(alignment: .leading) {
            
            NavigationLink(
                destination : BatchDetails(batch: batch)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true))
            {
                EmptyView()
            }
            .opacity(0)
            
            HStack{
                
                Image("\(batch.module)Bar")
                
                VStack(alignment :.leading, spacing : 10) {
                    Text(batch.module)
                        .textCase(.uppercase)
                        .modifier(TextStyle20())
                    
                    if Utility.getRole() == Constants.FACULTY {
                        Text("Start date: \(batch.fromDateString) @\(batch.fromTime)")
                    } else {
                        Text("Batch Start Date: \(batch.fromDateString)")
                    }
                    if Utility.getRole() == Constants.FACULTY {
                        Text("Hours Covered: \(batch.totalHours)")
                        Text("Total Students: \(batch.students.count)")
                    } else {
                        Text(batch.fromToTime)
                        Text("Faculty : \(batch.faculty)")
                    }
                }
                .modifier(TextStyle14())
                .lineLimit(0)
                
                Spacer()
                
                Image(batch.module)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 55, height: 55)
                    .padding(.bottom)
                    .padding(.horizontal)
            }
            .frame(maxWidth : .infinity)
            .background(Color.white)
            .clipped()
            .shadow(radius : 5)
            .padding(.top, 10)
        }
    }
}
