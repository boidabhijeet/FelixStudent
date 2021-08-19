//
//  ReferAndEarn1.swift
//  StudentAndFacultyApp
//
//  Created by Abhi’s iPhone on 22/06/21.
//

import SwiftUI

struct ReferAndEarn1: View {
    var body: some View {
        ZStack(alignment : .bottomTrailing){
            VStack{
                Spacer()
                Image("ReferAndEarn")
                    .resizable()
                    .frame(maxWidth : .infinity, maxHeight: .infinity)
                    .scaledToFit()
                
                Spacer().frame(height: 30)
                
                Text("Refer and Earn")
                    .font(.system(size: 30.0, weight: .regular, design: .default))
                
                Spacer().frame(height : 20)
                
                Text("Refer a friend and earn ₹500 for each successful referral. Generate referral link and share this personalised link directly with your friends.")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16.0))
                    .frame(maxWidth : .infinity)
                
                Spacer()
            }
        }
        .padding()
    }
}

struct ReferAndEarn1_Previews: PreviewProvider {
    static var previews: some View {
        ReferAndEarn1()
    }
}
