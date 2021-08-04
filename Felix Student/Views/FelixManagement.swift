//
//  FelixManagement.swift
//  Felix Student
//
//  Created by Mac on 15/04/21.
//

import SwiftUI
import AlertToast

struct FelixManagement: View {
    @State private var showToast = false
  
    var body: some View {
        VStack(alignment: .leading){
            
            Text("@ Felix Management")
                .font(.system(size: 20.0, weight: .semibold))
            
            Divider()
            
            Spacer().frame(maxHeight : 25)
            
            NavigationLink(
                destination: FelixFeedback()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                ,
                label: {
                    HStack(spacing: 10) {
                        Image("FeedbackIcon")
                        Text("Give Feedback")
                    }
                    .modifier(HStackModifier())
                })
            
            
            Spacer().frame(maxHeight : 25)
            
            NavigationLink(
                destination: ReferAndEarn()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                ,
                label: {
                    HStack(spacing: 10) {
                        Image("ReferAndEarnIcon")
                        Text("Refer & Earn")
                    }
                    .modifier(HStackModifier())
                })
            
            
            Spacer().frame(maxHeight : 25)
            
            NavigationLink(
                destination: RaiseTicket()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                ,
                label: {
                    HStack(spacing: 10) {
                        Image("RaiseATicketIcon")
                        Text("Raise A Ticket")
                    }
                    .modifier(HStackModifier())
                })
            Spacer()
        }
        .padding()
        .foregroundColor(.black)
        .font(.system(size: 18.0))
        .navigationBarHidden(true)
        .toast(isPresenting: $showToast){
            AlertToast(type: .regular, title: ToastAlert.felixFeedback)
        }
    }
}

struct FelixManagement_Previews: PreviewProvider {
    static var previews: some View {
        FelixManagement()
    }
}
