import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var index: Int = 0
    
    private var APIkey: String = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYWRlNDdjNjNmYWM0NGIwNmE1Y2Q4YTdiNDQxMjEzZiIsIm5iZiI6MTczMjExNDE5Mi44ODI3MjY3LCJzdWIiOiI2NzMyYWZkMDc4OWQyZDNkZmU5NDNiODciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.lm61hFKDKhIx7Qpoi1xLKVJQiopu-9fZ_niBUSywyA0"
    
    var movie: Movie? {
        guard !movies.isEmpty else { return nil }
        return movies[index % movies.count]
    }
    
    func fetchMovies() async {
        let baseURL = "https://api.themoviedb.org/3/discover/movie"
        var components = URLComponents(string: baseURL)!
        
        components.queryItems = [
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "include_video", value: "false"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
        ]
        
        guard let url = components.url else {
            print("URL inválida")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(APIkey)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.movies = movieResponse.results
                    }
                    print("Filmes carregados com sucesso: \(movieResponse.results.count)")
                } else {
                    print("Erro: Código de status \(httpResponse.statusCode)")
                    print(String(data: data, encoding: .utf8) ?? "Sem mensagem de erro")
                }
            }
        } catch {
            print("Erro na requisição: \(error.localizedDescription)")
        }
    }
}
