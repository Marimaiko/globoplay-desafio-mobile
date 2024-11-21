
import SwiftUI

struct FavoritesView: View {
    @StateObject private var movieViewModel = MovieViewModel()
    @StateObject private var tvshowViewModel = TVShowViewModel()
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if favoritesViewModel.favoritesMovies.isEmpty {
                    Text("Nenhum favorito encontrado.")
                        .foregroundColor(Color.black)
                } else {
                    List(favoritesViewModel.favoritesMovies) { movie in
                        MovieCardView(movie: movie, proxy: nil, favoritesViewModel: favoritesViewModel)
                    }
                }
            }
            .navigationTitle("Favoritos")
            .navigationBarTitleTextColor(.white)
        }
        .background(Color.black)
        .onAppear {
            Task {
                await movieViewModel.fetchMovies()
                await tvshowViewModel.fetchTVShows()
            }
        }
    }
}
