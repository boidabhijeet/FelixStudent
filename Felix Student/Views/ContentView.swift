//
//  ContentView.swift
//  Felix Student
//
//  Created by Mac on 13/04/21.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    func getUser() {
        
        SessionStore.shared.listen()
    }
    
    @State private var isActive : Bool = false
    init() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        navigationBarAppearace.tintColor = #colorLiteral(red: 0, green: 0.4377841353, blue: 0.654399991, alpha: 1)
    }
    var body: some View {
        VStack {
        if Auth.auth().currentUser != nil {
            Tabbar()
        } else {
        NavigationView {

            Group {

                    SelectRole()
                }
            }
        .navigationBarColor(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1))
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.rootPresentationMode, self.$isActive)
        
    }
        }.onAppear(perform: {
        getUser()
    })

    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(navigationStack: NavigationStack()).environmentObject(SessionStore.shared)
//    }
//}
//
extension View {
 
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }

}
