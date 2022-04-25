import SwiftUI

struct ContentView: View {
    
    init() {
            UITabBar.appearance().barTintColor = UIColor.blue
        }

    var body: some View {
        VStack {
            TabView {
                EntropyView()
                    .tabItem {
                        Label("ENTROPY", systemImage: "gamecontroller.fill")


                    }

                MyStoryView()
                    .tabItem {
                        Label("MY STORY", systemImage: "books.vertical.fill")
                        
                    }
            }
            .accentColor(Color.white)
        }
    }
}
