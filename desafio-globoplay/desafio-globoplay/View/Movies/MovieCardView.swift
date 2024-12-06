
import SwiftUI

struct MovieCardView: View {
    let movie: Movie
    let proxy: GeometryProxy?
    
    @ObservedObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        VStack {
            if let validProxy = proxy {
                let scale = getScale(proxy: validProxy)
                
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 225)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                } placeholder: {
                    Rectangle().fill(Color.gray.opacity(0.3))
                        .frame(width: 150, height: 225)
                        .cornerRadius(5)
                }
            } else {
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 225)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                } placeholder: {
                    Rectangle().fill(Color.gray.opacity(0.3))
                        .frame(width: 150, height: 225)
                        .cornerRadius(5)
                }
            }
                Text(movie.original_title)
                    .padding(.top)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fontWeight(.bold)
                
                Button(action: {
                    if favoritesViewModel.favoritesMovies.contains(where: { $0.id == movie.id }) {
                        favoritesViewModel.removeFavoriteMovie(movie: movie)
                    } else {
                        favoritesViewModel.addFavoriteMovie(movie: movie)
                    }
                }) {
                    Image(systemName: favoritesViewModel.favoritesMovies.contains(where: { $0.id == movie.id }) ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                    Text(favoritesViewModel.favoritesMovies.contains(where: { $0.id == movie.id }) ? "Favoritei" : "Curtiu?")
                        .foregroundColor(Color.yellow)
                    
                }
            }
        }
        private func getScale(proxy: GeometryProxy) -> CGFloat {
            var scale: CGFloat = 1
            let x = proxy.frame(in: .global).minX
            let diff = abs(x)
            if diff < 100 {
                scale = 1 + (100 - diff) / 500
            }
            return scale
        }
    }

