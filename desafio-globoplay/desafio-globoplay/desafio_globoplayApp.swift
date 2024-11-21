
import SwiftUI

@main
struct desafio_globoplayApp: App {
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State var showingSplash: Bool = true
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if showingSplash {
                    SplashView()
                } else {
                    TabView {
                        HomeView()
                            .tabItem {
                                Label("Home", systemImage: "house.fill")
                            }
                        FavoritesView()
                            .tabItem {
                                Label("Favoritos", systemImage: "star.fill")
                            }
                    }
                    .environmentObject(favoritesViewModel)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.showingSplash = false
                    }
                }
            }
        }
    }
}
