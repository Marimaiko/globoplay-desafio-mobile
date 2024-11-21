
import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    var onClose: () -> Void
    
    var body: some View {
        VStack {
            Text(movie.original_title)
                .foregroundStyle(Color.white)
                .font(.title)
                .padding()
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300)
                } placeholder: {
                    ProgressView()
                }
            }
            Text(movie.overview ?? "Sem descrição")
                .padding()
                .foregroundStyle(Color.white)
            Button ( action: {
                onClose()
            }) {
                Text("Voltar para Home")
            }
            .buttonStyle(.bordered)
        }
        .navigationTitle(movie.original_title)
        .background(Color.backgroundGray)
    }
}


