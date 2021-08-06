//
//  DisplayStudyMaterial.swift
//  Felix Student
//
//  Created by Abhi on 05/08/21.
//

import SwiftUI

struct DisplayStudyMaterial: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            Button(
                action: {self.presentationMode.wrappedValue.dismiss()},
                label: {
                    HStack{
                        Image(systemName: "arrow.left")
                        Text("Study Material")
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth : .infinity, alignment : .leading)
                    .padding(.leading, 15.0)
                })
            
            Divider()
            
            Spacer()
            
            Text("ToDo :- Implement DisplayStudyMaterial ")
            
            Spacer()
        }
    }
}
