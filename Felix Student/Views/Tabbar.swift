//
//  Tabbar.swift
//  Felix Student
//
//  Created by Mac on 14/04/21.
//

import SwiftUI

struct Tabbar: View {
    @State private var isActive : Bool = true
    @State var selected = 0
    var body: some View {
            NavigationView {
                ZStack(alignment: .bottom){
                    
                    VStack{
                        
                        if self.selected == 0{
                            HomePage()
                        }
                        else if self.selected == 1{
                            FelixManagement()
                        }
                        else{
                            if Utility.getRole() == Constants.FACULTY {
                                Settings(withURL: SessionStore.shared.user?.photoUrl ?? "")
                            } else {
                                Settings(withURL: SessionStore.shared.student?.photoUrl ?? "")
                            }
                            
                        }
                        
                    }.edgesIgnoringSafeArea(.all)
                    
                    FloatingTabbar(selected: self.$selected).padding()
                }
            }
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.rootPresentationMode, self.$isActive)

            
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar()
    }
}

struct FloatingTabbar : View {
    
    @Binding var selected : Int
    @State var expand = true
    
    var body : some View{
        
        HStack{
            
            Spacer(minLength: 0)
            
            HStack{
                
                if !self.expand{
                    
                    Button(action: {
                        
                        self.expand.toggle()
                        
                    }) {
                        
                        Image(systemName: "arrow.left").foregroundColor(.black).padding()
                    }
                }
                else{
                    
                    Button(action: {
                        
                        self.selected = 0
                        
                    }) {
                        
                        Image("icn_home").foregroundColor(self.selected == 0 ? .black : .gray).padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button(action: {
                        
                        self.selected = 1
                        
                    }) {
                        
                        Image("icn_felix")
                            .foregroundColor(self.selected == 1 ? .black : .gray)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button(action: {
                        
                        self.selected = 2
                        
                    }) {
                        
                        Image("icn_setting").foregroundColor(self.selected == 2 ? .black : .gray).padding(.horizontal)
                    }
                }
                
                
            }
            //            .padding(.vertical,self.expand ? 20 : 8)
            .padding(.horizontal,self.expand ? 35 : 8)
            .background(Color.white)
            .clipShape(Capsule())
            //            .padding(22)
            .border(Color.gray)
            .onLongPressGesture {
                
                self.expand.toggle()
            }
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6))
        }
        
        
    }
}
