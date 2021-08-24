//
//  CustomTabBar.swift
//  StudentAndFacultyApp
//
//  Created by Mac on 10/07/21.

import SwiftUI

struct CustomTabBar: View {
    
    @State private var index = 0
    @State private var isPresented = true
    
    let screenSize = UIScreen.main.bounds
    
    var body: some View {
        NavigationView{
            ZStack(alignment : .bottom){
                
                VStack{
                    if self.index == 0{
                        HomePage()
                    }
                    else if self.index == 1{
                        FelixManagement()
                    }
                    else{
                        if Utility.getRole() == Constants.FACULTY {
                            if SessionStore.shared.user?.photoUrl == ""  || SessionStore.shared.user?.photoUrl == nil {
                                Settings(url: URL(string: Constants.PlaceholderImage)!)
                            } else {
                                Settings(url: URL(string: SessionStore.shared.user!.photoUrl)!)
                            }
                            
                        } else {
                            if SessionStore.shared.student?.photoUrl == "" || SessionStore.shared.student?.photoUrl == nil {
                                Settings(url: URL(string: Constants.PlaceholderImage)!)
                            } else {
                                Settings(url: URL(string: SessionStore.shared.student!.photoUrl)!)
                            }
                        }
                    }
                }
                CircleTab(index: $index)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigationBarHidden(true)
    }
}

struct CircleTab : View {
    
    @Binding var index : Int
    var screenSize = UIScreen.main.bounds
    
    var body: some View{
        
        HStack(spacing : 10){
            
            Spacer()
            
            Button(action: {
                self.index = 0
                
            }, label: {
                VStack{
                    
                    if(self.index == 0)
                    {
                        Image("HomeIconRed")
                        Text("Home")
                            .foregroundColor(.red)
                        
                    }
                    else{
                        Image("homeIconBlack")
                        Text("Home")
                            .foregroundColor(.black)
                    }
                }
            })
            
            Spacer()
            
            Button(action: {
                self.index = 1
                
            }, label: {
                
                if self.index == 1 {
                    Image("FelixMiniLogoRed")
                        .padding()
                        .clipShape(Circle())
                        .offset(y : -40)
                        .padding(.bottom, -20)
                }
                else{
                    Image("FelixMiniLogo")
                        .padding()
                        .clipShape(Circle())
                        .offset(y : -40)
                        .padding(.bottom, -20)
                }
                
            })
            
            Spacer()
            
            Button(action: {
                self.index = 2
            }, label: {
                VStack{
                    if self.index == 2{
                        Image("settingsIconRed")
                        Text("Settings")
                            .foregroundColor(.red)
                    }
                    else{
                        Image("settingsIconBlack")
                        Text("Settings")
                            .foregroundColor(.black)
                    }
                }
            })

            Spacer()
            
        }
        .frame(width: screenSize.width * 0.9, height: 70, alignment: .center)
        .border(Color.gray, width: 0.2) //Check -- Remove Border
        .background(Color.white)
        .padding(.horizontal, 25)
        .font(.system(size: 10))
        .animation(.spring())
    }
}
struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}
