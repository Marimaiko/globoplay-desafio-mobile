
import SwiftUI

struct TvShowCardView: View {
    let tvShow: TVShow
    let proxy: GeometryProxy?
    @ObservedObject var favoritesViewModel: FavoritesViewModel

    var body: some View {
                VStack {
                    if let validProxy = proxy {
                        let scale = getScale(proxy: validProxy)
                        
                        AsyncImage(url: tvShow.posterURL) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 225)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5)
                                )
                                .clipped()
                                .cornerRadius(5)
                                .shadow(radius: 5)
                                .scaleEffect(CGSize(width: scale, height: scale))
                                .animation(.easeOut(duration: 0.5))
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 150, height: 225)
                                .cornerRadius(5)
                        }
                    } else {
                        AsyncImage(url: tvShow.posterURL) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 225)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5)
                                )
                                .clipped()
                                .cornerRadius(5)
                                .shadow(radius: 5)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 150, height: 225)
                                .cornerRadius(5)
                        }
                    }

                    Text(tvShow.name)
                        .padding(.top)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                        .lineLimit(2)
                        .frame(width: 150)
                        .fontWeight(.bold)
                    Button(action: {
                        if favoritesViewModel.favoritesShows.contains(where: { $0.id == tvShow.id }) {
                            favoritesViewModel.removeFavoriteShows(shows: tvShow)
                        } else {
                            favoritesViewModel.addFavoriteShows(shows: tvShow)
                        }
                    }) {
                        Image(systemName: favoritesViewModel.favoritesShows.contains(where: { $0.id == tvShow.id }) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                        Text(favoritesViewModel.favoritesShows.contains(where: { $0.id == tvShow.id }) ? "Favoritei" : "Curtiu?")
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
