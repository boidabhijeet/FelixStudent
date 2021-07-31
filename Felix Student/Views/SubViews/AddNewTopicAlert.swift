//
//  AddNewTopicAlert.swift
//  StudentAndFacultyApp
//
//  Created by Mac on 14/07/21.
//

import SwiftUI

struct AddNewTopicAlert: View {
    
    @State private var isExpanded = false
    @State private var timeSpentInHrs: Double = 0
    @State private var selectedTopic = "PYTHON"
    
    @Binding var topic : String
    @Binding var isPresented : Bool
    @Binding var note : String
    
    var title : String = "Add topic and time spent on it"
    var topics = ["PYTHON", "ANDROID", "UIUX"]
    let screenSize = UIScreen.main.bounds
    
    
    var body: some View {
        
        
        ZStack {
            
//            Color(.black).edgesIgnoringSafeArea(.all).opacity(0.8)
            
            VStack(alignment : .leading) {
                
                DisclosureGroup("Add New Topic", isExpanded: $isExpanded){
                    VStack{
                        ForEach(0..<topics.count){ index in
                            Text("\(topics[index])")
                                .padding()
                        }
                    }
                }
                .font(.system(size: 18, weight: .semibold, design: .default))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 5, y : 6)
                
                Spacer().frame(maxHeight : 40)
                
                Text(title)
                    .font(.system(size: 15))
                
                Spacer().frame(maxHeight : 20)
                
                Group{
                    
                    TextField("Topic", text: $topic)
                        .padding(.top, 20)
                    
                    Divider().background(Color.black)
                    
                    TextField("Note (Optional)", text: $note)
                        .padding(.top, 20)
                
                    Divider().background(Color.black)

                    HStack{
                        Text("Time Spent")
                        Spacer()
                        Text("\(timeSpentInHrs, specifier: "%.1f") Hrs")
                    }
                    .padding(.top, 20)
                    
                }
                .font(.system(size: 15))
                
                
                Slider(value: $timeSpentInHrs, in: 1...10)
                    .accentColor(.red)
            
                Text("Note* : Time cannot change once you add.")
                    .font(.system(size: 12))
                
                Spacer().frame(maxHeight : 40)

                HStack{
                    Spacer()
                    
                    Button("CANCEL"){
                        self.isPresented =  false
                        
                    }
                    
                    Button("OK"){
                        self.isPresented =  false
                    }
                }
                .padding(.bottom)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.red)
                
                Spacer()
                
            }
            .padding()
            .frame(width: screenSize.width * 0.9, height: screenSize.height * 0.9)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .offset(y: isPresented ? 0 : screenSize.height)
            .animation(.spring())
        }
        
        
    }
}

struct AddNewTopicAlert_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTopicAlert(topic: .constant(""), isPresented: .constant(true), note: .constant(""))
    }
}
