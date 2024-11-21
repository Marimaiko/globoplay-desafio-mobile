
import SwiftUI

struct SplashView: View {
    @State var showingSplash: Bool = false
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        VStack {
            Image("splash")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        }
        .background(Color.backgroundGray)
    }
}
