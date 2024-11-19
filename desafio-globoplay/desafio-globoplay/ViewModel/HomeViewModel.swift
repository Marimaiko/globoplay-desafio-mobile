//
//  HomeViewModel.swift
//  desafio-globoplay
//
//  Created by Mariana Maiko on 14/11/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var movies: [Movie] = [] // Array de filmes que será atualizado com a resposta da API
    private var cancellables = Set<AnyCancellable>()
    
    // Função para buscar os filmes
    func fetchMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/changes")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "1")
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYWRlNDdjNjNmYWM0NGIwNmE1Y2Q4YTdiNDQxMjEzZiIsIm5iZiI6MTczMTM3OTU3Ny4xMTYwMDI4LCJzdWIiOiI2NzMyYWZkMDc4OWQyZDNkZmU5NDNiODciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.hf2XK1wP61ZtzOwuGlC8VjYj2pD6eBgzDEv6ddAevrI"
        ]
        
        // Usar Combine para fazer a requisição
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: MovieResponse.self, decoder: JSONDecoder()) // Decodificar a resposta em `MovieResponse`
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Erro ao carregar filmes:", error)
                }
            }, receiveValue: { [weak self] movieResponse in
                self?.movies = movieResponse.results // Atualizar a lista de filmes com a resposta
            })
            .store(in: &cancellables)
    }
    
    
}
