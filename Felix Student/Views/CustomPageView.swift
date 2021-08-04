import SwiftUI

struct CustomPageView: View {
    
    @State private var currentIndex = 0
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        UIPageControl.appearance().pageIndicatorTintColor = .gray
    }
    
    var body: some View{
        
        NavigationView {
            ZStack(alignment : .bottomTrailing){
                TabView(selection: $currentIndex) {
                    TrackCourseProgress().tag(0)
                    GiveFacultyFeedback().tag(1)
                    ReferAndEarn1().tag(2)
                }
                .tabViewStyle(PageTabViewStyle())
                
                NavigationLink(
                    destination: SelectRole()
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true)){
                    if currentIndex == 0 || currentIndex == 1{
                        Text("Skip").foregroundColor(.red).padding()
                    }
                    else {
                        Text("Continue").foregroundColor(.red).padding()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

