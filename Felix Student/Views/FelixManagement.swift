//
//  FelixManagement.swift
//  Felix Student
//
//  Created by Mac on 15/04/21.
//

import SwiftUI

struct FelixManagement: View {
    var body: some View {
        //        NavigationView {
        VStack(alignment: .center) {
            Spacer()
            NavigationLink(
                destination: FelixFeedback()) {
                HStack(spacing: 10) {
                    Image("icn_giveFeedback")
                    Text("Give Feedback")
                }.font(.title)
                .padding()
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                
            }
            .isDetailLink(false)
            .frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 100,
                    alignment: .leading)
            .border(Color.gray).frame(maxWidth: .infinity)
            
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
            .frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 100,
                    alignment: .leading)
            .border(Color.gray).frame(maxWidth: .infinity)
            
            NavigationLink(
                destination: RaiseTicket()) {
                HStack(spacing: 10) {
                    Image("icn_raiseticket")
                    Text("Raise a Ticket")
                }.font(.title)
                .padding()
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                
            }
            .isDetailLink(false)
            .frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 100,
                    alignment: .leading)
            .border(Color.gray).frame(maxWidth: .infinity)
            Spacer()
        }.padding()
        //            .frame(minWidth: 0,
        //                   maxWidth: .infinity,
        //                   minHeight: 0,
        //                   maxHeight: .infinity,
        //                   alignment: .leading)
        .navigationBarTitle("@ Felix Management")
        
    }
    //    }
}

struct FelixManagement_Previews: PreviewProvider {
    static var previews: some View {
        FelixManagement()
    }
}
