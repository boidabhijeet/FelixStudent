//
//  StudentFeedbackRow.swift
//  Felix Student
//
//  Created by Abhi on 06/08/21.
//

import SwiftUI

struct StudentFeedbackRow: View {
    var feedback: Feedbacks
    
    var body: some View {
        GeometryReader { geo in
            
            VStack(alignment : .leading) {
                
                HStack(spacing : 15){
                    Image("personCircle")
                    Text(feedback.name)
                        .font(.system(size: 20, weight: .semibold))
                        .textCase(.uppercase)

                }
                
                Spacer().frame(maxHeight: 40)
                
                HStack {
                    
                    VStack {
                        Image(feedback.rating == 1 ? "notUnderstoodRed" : "notUnderstoodGray")
                        Text("Not Understood")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Image(feedback.rating == 2 ? "partiallyUnderstood" : "partiallyUnderstoodGray")
                        Text("Partially Understood")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Image(feedback.rating == 3 ? "understood" : "understoodGray")
                        Text("Understood")
                    }
                }
                .modifier(TextStyle10())
                
                
                Spacer().frame(maxHeight: 40)
                
                Text("Comment:")
                    .font(.system(size: 14.0, weight: .semibold, design: .default))
                
                Spacer().frame(maxHeight: 10)
                
                Text(feedback.comment)
                    .font(.system(size: 14.0))
            }
            .padding()
            .frame(maxWidth: geo.size.width * 0.9)
            .modifier(GrayShadow())
            .padding(.horizontal)
            
            Spacer()
            
        }
    }
}
