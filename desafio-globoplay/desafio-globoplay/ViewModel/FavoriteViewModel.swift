
import SwiftUI
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var favoritesMovies: [Movie] = []
    @Published var favoritesShows: [TVShow] = []

    func addFavoriteMovie(movie: Movie) {
        if !favoritesMovies.contains(where: { $0.id == movie.id }) {
            favoritesMovies.append(movie)
            print("Adicionado favorito: \(movie.original_title)")
        }
    }

    func removeFavoriteMovie(movie: Movie) {
        favoritesMovies.removeAll { $0.id == movie.id }
    }
    
    func addFavoriteShows(shows: TVShow) {
        if !favoritesShows.contains(where: { $0.id == shows.id }) {
            favoritesShows.append(shows)
            print("Adicionado favorito: \(shows.name)")
        }
    }

    func removeFavoriteShows(shows: TVShow) {
        favoritesShows.removeAll { $0.id == shows.id }
    }
}


