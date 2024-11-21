
import SwiftUI

class TVShowViewModel: ObservableObject {
    @Published var tvShows: [TVShow] = []
    
    private var APIkey: String = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYWRlNDdjNjNmYWM0NGIwNmE1Y2Q4YTdiNDQxMjEzZiIsIm5iZiI6MTczMjExNDE5Mi44ODI3MjY3LCJzdWIiOiI2NzMyYWZkMDc4OWQyZDNkZmU5NDNiODciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.lm61hFKDKhIx7Qpoi1xLKVJQiopu-9fZ_niBUSywyA0"

    func fetchTVShows() async {
        let baseURL = "https://api.themoviedb.org/3/tv/popular"
        var components = URLComponents(string: baseURL)!
        
        components.queryItems = [
            URLQueryItem(name: "language", value: "pt-BR"),
            URLQueryItem(name: "page", value: "1"),
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
                    let tvShowResponse = try JSONDecoder().decode(TVShowResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.tvShows = tvShowResponse.results
                    }
                    print("🐝 Shows carregados com sucesso: \(tvShowResponse.results.count)")
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

