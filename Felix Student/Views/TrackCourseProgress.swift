//
//  TrackCourseProgress.swift
//  Felix Student
//
//  Created by Abhi on 30/07/21.
//

import SwiftUI


struct TrackCourseProgress: View {
    var body: some View {
        ZStack(alignment : .bottomTrailing) {
            VStack{
                Spacer()
                
                Image("TrackCourseProgress")
                    .resizable()
                    .frame(maxWidth : .infinity, maxHeight: .infinity)
                    .scaledToFit()
                
                Spacer().frame(maxHeight : 30)
                
                Text("Track Course Progress")
                    .font(.system(size: 30))
     
                Spacer().frame(maxHeight : 20)

                Text("If the Course completion status block is added, students can see their progress during the course")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16.0))
                    .frame(maxWidth : .infinity)
                Spacer()
                }
        }.padding()
    }
}
