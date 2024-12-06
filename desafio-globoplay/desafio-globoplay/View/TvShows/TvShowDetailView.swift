
import SwiftUI

struct TvShowDetailView: View {
    let tvShow: TVShow
    var onClose: () -> Void

    var body: some View {
        VStack {
            Text(tvShow.name)
                .font(.title)
                .padding()
                .foregroundStyle(Color.white)
            if let posterURL = tvShow.posterURL {
                AsyncImage(url: posterURL) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300)
                } placeholder: {
                    ProgressView()
                }
            }
            Text(tvShow.overview ?? "Sem descrição")
                .padding()
                .foregroundStyle(Color.white)
            Button ( action: {
                onClose()
            }) {
                Text("Voltar para Home")
            }
            .buttonStyle(.bordered)
        }
        .background(Color.backgroundGray)
        .navigationTitle(tvShow.name)
    }
}

