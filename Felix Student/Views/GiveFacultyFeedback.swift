//
//  GiveFacultyFeedback.swift
//  StudentAndFacultyApp
//
//  Created by Abhi’s iPhone on 16/06/21.
//

import SwiftUI

struct GiveFacultyFeedback: View {
    var body: some View {
        ZStack(alignment : .bottomTrailing){
            VStack{
                Spacer()
                
                Image("GiveFacultyFeedback")
                    .resizable()
                    .frame(maxWidth : .infinity, maxHeight: .infinity)
                    .scaledToFit()
                
                Spacer().frame(maxHeight : 30)
                
                Text("Give faculty feedback")
                    .font(.system(size: 30.0, weight: .regular, design: .default))
                
                Spacer().frame(maxHeight : 20)
                
                Text("Monitoring student learning through regular assessment is an important element of an instructor's job.")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16.0))
                    .frame(maxWidth : .infinity)
                
                Spacer()
            }
        }
        .padding()
    }
}

struct GiveFacultyFeedback_Previews: PreviewProvider {
    static var previews: some View {
        GiveFacultyFeedback()
    }
}
