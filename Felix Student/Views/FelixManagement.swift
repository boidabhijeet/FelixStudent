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
    init() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        navigationBarAppearace.tintColor = #colorLiteral(red: 0, green: 0.4377841353, blue: 0.654399991, alpha: 1)
    }
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white)
                    .frame(width: 350, height: 60)
            NavigationLink(
                destination: FelixFeedback()) {
                HStack(spacing: 10) {
                    Image("icn_giveFeedback")
                    Text("Give Feedback")
                }.font(.title)
                .padding()
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                
            }.isDetailLink(false)
            }
            .padding()
            .shadow(color: .gray, radius: 10)
                    
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white)
                    .frame(width: 350, height: 60)
            NavigationLink(
                destination: ReferAndEarn()) {
                HStack(spacing: 10) {
                    Image("icn_referandearn")
                    Text("Refer & Earn")
                }.font(.title)
                .padding()
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                
            }
            .isDetailLink(false)
            }
            .padding()
            .shadow(color: .gray, radius: 10)
            
//            NavigationLink(
//                destination: RaiseTicket()) {
//                HStack(spacing: 10) {
//                    Image("Ticket")
//                    Text("Raise a Ticket")
//                }.font(.title)
//                .padding()
//                .foregroundColor(Color.black)
//                .multilineTextAlignment(.center)
//
//            }
//            .isDetailLink(false)
//            .frame(minWidth: 0,
//                    maxWidth: .infinity,
//                    minHeight: 0,
//                    maxHeight: 100,
//                    alignment: .leading)
//            .border(Color.gray).frame(maxWidth: .infinity)
           
        }
        .padding(.top, 100)
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
       
        .navigationBarTitle("@ Felix Management")
        .toast(isPresenting: $showToast){
            
            // `.alert` is the default displayMode
            AlertToast(type: .regular, title: ToastAlert.felixFeedback)
        }
    }
}

struct FelixManagement_Previews: PreviewProvider {
    static var previews: some View {
        FelixManagement()
    }
}
