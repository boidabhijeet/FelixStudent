//
//  Tabbar.swift
//  Felix Student
//
//  Created by Mac on 14/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct Tabbar: View {
    @State private var isActive : Bool = true
    @State var selected = 0
    init() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        navigationBarAppearace.tintColor = #colorLiteral(red: 0, green: 0.4377841353, blue: 0.654399991, alpha: 1)
    }
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
                        
                    }.edgesIgnoringSafeArea(.all)
                    
                    FloatingTabbar(selected: self.$selected)
                        .padding()
                        .accentColor(.red)
                }
            }
        .navigationBarColor(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1))
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
//        ZStack {
//            RoundedRectangle(cornerRadius: 25, style: .continuous)
//                .fill(Color.white)
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
                        if selected == 0 {
                            Image("ic_home_24px").padding(.horizontal)
                        } else {
                            Image("icn_home").foregroundColor(self.selected == 0 ? .black : .gray).padding(.horizontal)
                        }
                        
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button(action: {
                        
                        self.selected = 1
                        
                    }) {
                        if selected == 1 {
                            Image("Red Felix").padding(.horizontal)
                        } else {
                            Image("icn_felix")
                                .foregroundColor(self.selected == 1 ? .black : .gray)
                                .padding(.horizontal)
                        }
                       
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button(action: {
                        
                        self.selected = 2
                        
                    }) {
                        if selected == 2 {
                            Image("Icon material-settings").padding(.horizontal)
                        } else {
                            Image("icn_setting").foregroundColor(self.selected == 2 ? .black : .gray).padding(.horizontal)
                        }
                       
                    }
                }
                
                
            }
            //            .padding(.vertical,self.expand ? 20 : 8)
            .padding(.horizontal,self.expand ? 35 : 8)
            .background(Color.white)
//            .clipShape(Capsule())
            //            .padding(22)
//            .border(Color.gray)
            .onLongPressGesture {
                
                self.expand.toggle()
            }
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6))
//        }
        
        } .padding()
        .shadow(color: Color.gray, radius: 5)
    }
}
struct NavigationBarModifier: ViewModifier {
        
    var backgroundColor: UIColor?
    
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .black

    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}
