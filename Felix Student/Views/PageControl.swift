//
//  PageControl.swift
//  Felix Student
//
//  Created by Mac on 14/04/21.
//

import SwiftUI

struct PageControl: View {
    var body: some View {
        TabView {
            FirstView()
            SecondView()
            ThirdView()
        }
        
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct PageControl_Previews: PreviewProvider {
    static var previews: some View {
        PageControl()
    }
}

struct FirstView: View {
    var body: some View {
        VStack {
            Image("UI/UX")
            Text("Track Course Progress")
                .font(.largeTitle)
            Text("If the course completion status block is added, students can see their progress during the course.").padding()
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            Image("FacultyFeedback")
            Text("Give Faculty Feedback")
                .font(.largeTitle)
            Text("Monitoring student learning through regular assessment is an important element of an instructor's job.").padding()
        }
    }
}

struct ThirdView: View {
    var body: some View {
        VStack {
            Image("referandEarn")
            Text("Refer and Earn")
                .font(.largeTitle)
            Text("Refer a friend and earn ₹500 for each successful referral. Generate referral link and share this personalised link directly with your friends.").padding()
        }
    }
}
