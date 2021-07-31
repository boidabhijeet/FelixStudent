//
//  CustomAlert.swift
//  StudentAndFacultyApp
//
//  Created by Mac on 14/07/21.
//

import SwiftUI

struct ForgotPwdAlert: View {
    
    let screenSize = UIScreen.main.bounds
    @Binding var isPresented : Bool
    @Binding var text : String
    var title : String = "Enter your email to send reset link"
    var body: some View {
        VStack(alignment : .leading) {
            Text(title)
                .font(.system(size: 15))

            Spacer()
            
            TextField("Email", text: $text)
            
            Divider()
            
            Spacer().frame(maxHeight : 20)
            
            HStack{
                Spacer()
                
                Button("CANCEL"){
                    self.isPresented =  false
                    
                }
                
                Button("SEND"){
                    //FIX ME
                }
            }
            .font(.system(size: 13, weight: .semibold, design: .default))
            .foregroundColor(.red)
    
            Spacer()

        }
        .padding()
        .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.2)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .offset(y: isPresented ? 0 : screenSize.height)
        .animation(.spring())
        .shadow(color: .gray, radius: 6)
    }
}

struct ForgotPwdAlert_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPwdAlert(isPresented: .constant(true), text: .constant(""))
    }
}
