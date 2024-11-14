//
//  ShowService.swift
//  desafio-globoplay
//
//  Created by Mariana Maiko on 12/11/24.
//

import Foundation

//protocol ShowService {
//    func fetchShows(from endpoint: ShowListEndpoint, completion: @escaping (Result<ShowResponse, ShowError>) -> ())
//    func fetchMovie(id: Int, completion: @escaping (Result<Show, ShowError>) -> ())
//}

enum ShowListEndpoint: String, CaseIterable {
    case nowPlaying = "nowPlaying"
    case upcoming
    case topRated = "topRated"
    case popular
    
    var description: String {
        switch self {
        case .nowPlaying: return "Now playing"
        case .upcoming: return "Upcoming"
        case .topRated: return "Top rated"
        case .popular: return "Popular"
        }
    }
}

enum ShowError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Erro na api"
        case .invalidEndpoint: return "Endpoint inválido"
        }
    }
}
