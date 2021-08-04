//
//  RaiseTicket.swift
//  StudentAndFacultyApp
//
//  Created by Abhi’s iPhone on 22/06/21.
//

import SwiftUI

struct RaiseTicket: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var descriptionText : String = ""
    @State private var selectedTicket = 12191
    @State private var isExpanded = false
    var tickets = [12191,22433,34545,42111,53323] //Create dynamically later
    var screenSize = UIScreen.main.bounds
    
    var body: some View {
        VStack(alignment : .leading){
            
            Button(
                action: {self.presentationMode.wrappedValue.dismiss()},
                label: {
                    HStack{
                        Image(systemName: "arrow.left")
                        Text("Raise a ticket")
                    }
                    .foregroundColor(.black)
                })
                .padding(.horizontal)
            
            Divider()
            
            DisclosureGroup("Select Ticket", isExpanded: $isExpanded){
                ForEach(0..<tickets.count){ item in
                    Text("\(tickets[item])").padding(10)
                }
            }
            .padding()
            .frame(maxWidth: screenSize.width * 0.9, alignment: .center)
            .background(Color.white)
            .clipped()
            .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 5)
            .padding()
            .animation(.spring())
            
            Text("Write a note")
                .padding(.horizontal)
            
            TextField("Describe your issue or idea...", text: $descriptionText)
                .padding()
                .frame(maxWidth: screenSize.width * 0.9, maxHeight: 143.0, alignment: .topLeading)
                .background(Color(red: 1.0, green: 0.78, blue: 0.796))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            
            Spacer()
            
            Button("Send") {
                //code
            }
            .font(.system(size: 24, weight: .semibold, design: .default))
            .frame(maxWidth: screenSize.width, minHeight: 65)
            .background(Color.red)
            .foregroundColor(.white)
            
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct RaiseTicket_Previews: PreviewProvider {
    static var previews: some View {
        RaiseTicket()
    }
}
