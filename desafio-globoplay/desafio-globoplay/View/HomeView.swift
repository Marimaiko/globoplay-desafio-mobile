
import SwiftUI
import Foundation

struct HomeView: View {
    @StateObject private var movieViewModel = MovieViewModel()
    @StateObject private var tvshowViewModel = TVShowViewModel()
    @State private var selectedMovie: Movie?
    @State private var selectedTVShow: TVShow?
    @StateObject private var favoritesViewModel = FavoritesViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Globoplay")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.custom("Montserrat", size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .padding()
            }
            .background(Color.black)
            
            ScrollView {
                SectionView(
                    title: "Filmes",
                    items: movieViewModel.movies,
                    cardView: { movie, proxy in
                        MovieCardView(movie: movie, proxy: proxy, favoritesViewModel: favoritesViewModel)
                            .onTapGesture { selectedMovie = movie }
                    }
                )
                .fullScreenCover(item: $selectedMovie) { movie in
                    MovieDetailView(movie: movie) {
                        selectedMovie = nil
                    }
                        .navigationBarHidden(true)
                }
                
                SectionView(
                    title: "Séries de TV",
                    items: tvshowViewModel.tvShows,
                    cardView: { tvShow, proxy in
                        TvShowCardView(tvShow: tvShow, proxy: proxy, favoritesViewModel: favoritesViewModel)
                            .onTapGesture { selectedTVShow = tvShow }
                    }
                )
                .fullScreenCover(item: $selectedTVShow) { tvShow in
                    TvShowDetailView(tvShow: tvShow) {
                        selectedTVShow = nil
                    }
                        .navigationBarHidden(true)
                }
            }

            .onAppear {
                Task {
                    await movieViewModel.fetchMovies()
                    await tvshowViewModel.fetchTVShows()
                }
            }
        }
        .background(Color.backgroundGray)
    }
}

struct SectionView<Item: Identifiable, CardView: View>: View {
    let title: String
    let items: [Item]
    let cardView: (Item, GeometryProxy) -> CardView

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 52) {
                    ForEach(items, id: \.id) { item in
                        GeometryReader { proxy in
                            cardView(item, proxy)
                                .frame(width: 128, height: 300)
                        }
                        .frame(width: 128, height: 300)
                    }
                }
                .padding(32)
            }
        }
    }
}

extension View {
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor]
        return self
    }
}

#Preview {
    HomeView()
}
