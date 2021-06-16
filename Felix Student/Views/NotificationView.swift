//
//  NotificationView.swift
//  Felix Student
//
//  Created by Mac on 03/06/21.
//

import SwiftUI

struct NotificationView: View {
    @StateObject var notificationVM = NotificationViewModel()
    
    func dateFormatting(postedAt: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(postedAt) ?? TimeInterval(0))
        let formate = date.getFormattedDate(format: "dd/MM/yyyy hh:mm:ss") // Set output formate
        return formate
    }
    
    var body: some View {
        List(notificationVM.notifications, id: \.id) { notification in
           
        
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
            HStack {
                VStack {
                Image("icn_placeholderImage") .resizable()
                    .frame(width: 30, height: 30)
                }.padding()
                VStack(alignment: .leading) {
                    Text(notification.title)
                    Text(dateFormatting(postedAt: notification.postedAt))
                }.padding(.bottom, 5)
                Spacer()
            }.padding(5)
        }.padding()
        .shadow(color: Color.gray, radius: 5 )
        } .onAppear(perform: {
            notificationVM.fetchNotifications()
        })
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
