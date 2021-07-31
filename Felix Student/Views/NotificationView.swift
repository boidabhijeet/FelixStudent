//
//  NotificationView.swift
//  Felix Student
//
//  Created by Mac on 03/06/21.
//

import SwiftUI

struct NotificationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var notificationVM = NotificationViewModel()
    var screenSize = UIScreen.main.bounds
    func dateFormatting(postedAt: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(postedAt) ?? TimeInterval(0))
        let formate = date.getFormattedDate(format: "dd/MM/yyyy hh:mm:ss") // Set output formate
        return formate
    }
    
    var body: some View {
        Button(
            action: {self.presentationMode.wrappedValue.dismiss()},
            label: {
                HStack{
                    Image(systemName: "arrow.left")
                    Text("Notifications")
                }
                .foregroundColor(.black)
                .frame(maxWidth : .infinity, alignment : .leading)
                .padding(.leading, 15.0)
            })
        
        Divider()
        
        List(notificationVM.notifications, id: \.id) { notification in
            HStack {

                Image("icn_placeholderImage")
                    .renderingMode(.original)
                    .resizable()
                    .frame(maxWidth: 60, maxHeight: 60)
                    .padding()
                

                VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/){
                    Text(notification.title)
                        .multilineTextAlignment(.leading)
                    Text(dateFormatting(postedAt: notification.postedAt))
                        .multilineTextAlignment(.leading)
                }
//                .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .frame(width : screenSize.width * 0.7)
                Spacer()
            }
            .frame(width : screenSize.width * 0.9)
            .modifier(GrayShadow())
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .onAppear(perform: {
            notificationVM.fetchNotifications()
        })
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
