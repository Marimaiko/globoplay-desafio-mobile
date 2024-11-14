//
//  apiService.swift
//  desafio-globoplay
//
//  Created by Mariana Maiko on 12/11/24.
//    "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYWRlNDdjNjNmYWM0NGIwNmE1Y2Q4YTdiNDQxMjEzZiIsIm5iZiI6MTczMTM3OTU3Ny4xMTYwMDI4LCJzdWIiOiI2NzMyYWZkMDc4OWQyZDNkZmU5NDNiODciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.hf2XK1wP61ZtzOwuGlC8VjYj2pD6eBgzDEv6ddAevrI"

import Foundation

//https://api.themoviedb.org/3/movie/{movie_id}/similar


let baseURL = "https://api.themoviedb.org/3"
let posterURL = "https://image.tmdb.org/t/p/original"
let youtubeURL = "https://www.youtube.com/watch?v="

let headers = [
  "accept": "application/json",
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYWRlNDdjNjNmYWM0NGIwNmE1Y2Q4YTdiNDQxMjEzZiIsIm5iZiI6MTczMTM3OTU3Ny4xMTYwMDI4LCJzdWIiOiI2NzMyYWZkMDc4OWQyZDNkZmU5NDNiODciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.hf2XK1wP61ZtzOwuGlC8VjYj2pD6eBgzDEv6ddAevrI"
]

enum APIURLs{
    
    case getMovies
    case getTVShows
    
    case detailsMovie(Int)
    case detailsTVShow(Int)
    
    case creditsMovie(Int)
    case creditsTvShow(Int)
    
    case similarMovies(Int)
    case similarTVShows(Int)
    
    case getMovieVideos(Int)
    func request() throws -> URLRequest {
        switch self {
        case .getMovies:
            return createRequest(withURL: "\(baseURL)/movie/now_playing")
        case .getTVShows:
            return createRequest(withURL: "\(baseURL)/tv/airing_today")
        case let .detailsMovie(movieId):
            return createRequest(withURL: "\(baseURL)/movie/\(movieId)")
        case let .detailsTVShow(tvShowId):
            return createRequest(withURL: "\(baseURL)/tv/\(tvShowId)")
        case let .creditsMovie(movieId):
            return createRequest(withURL: "\(baseURL)/movie/\(movieId)/credits")
        case let .creditsTvShow(tvShowId):
            return createRequest(withURL: "\(baseURL)/tv/\(tvShowId)/credits")
        case let .similarMovies(movieId):
            return createRequest(withURL: "\(baseURL)/movie/\(movieId)/similar")
        case let .similarTVShows(tvShowId):
            return createRequest(withURL: "\(baseURL)/tv/\(tvShowId)/similar")
        case let .getMovieVideos(movieId):
            return createRequest(withURL: "\(baseURL)/movie/\(movieId)/videos")
        }
    }
    
    private func createRequest(withURL url: String) -> URLRequest{
        var request = URLRequest(url: URL.init(string: url)!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
}
