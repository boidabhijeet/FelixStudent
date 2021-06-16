//
//  RaiseTicket.swift
//  Felix Student
//
//  Created by Mac on 15/04/21.
//

import SwiftUI

struct RaiseTicket: View {
    var body: some View {
            VStack {
                Text("Write a note")
                TextEditor(text: .constant("Describe your issue or idea")).foregroundColor(.black).border(Color.black)
                Button(action: {
                    print("Edit button was tapped")
                }) {
                    HStack(spacing: 10) {
                        Text("Send")
                    }
                } .padding(10)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.red)
            }.navigationTitle("Raise a Ticket")
            .navigationBarTitleDisplayMode(.inline)
        }
}

struct RaiseTicket_Previews: PreviewProvider {
    static var previews: some View {
        RaiseTicket()
    }
}
