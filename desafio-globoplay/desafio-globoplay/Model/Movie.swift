////
////  Movie.swift
////  desafio-globoplay
////
////  Created by Mariana Maiko on 12/11/24.
////
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let posterPath: String?

    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }
}


//struct MoviesResults: Codable {
//    var dates: Dates?
//    var page: Int?
//    var results: [Movie]?
//    var totalPages, totalResults: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case dates, page, results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
//    }
//}
//
//// MARK: - Dates
//struct Dates: Codable {
//    var maximum, minimum: String?
//}
//
//// MARK: - Result
//struct Movie: Codable, Result {
//    var posterPath: String?
//    var adult: Bool?
//    var backdropPath: String?
//    var genreIDS: [Int]?
//    var id: Int?
//    var originalLanguage: String?
//    var originalTitle, overview: String?
//    var popularity: Double?
//    var releaseDate, title: String?
//    var video: Bool?
//    var voteAverage: Double?
//    var voteCount: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case genreIDS = "genre_ids"
//        case id
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview, popularity
//        case posterPath = "poster_path"
//        case releaseDate = "release_date"
//        case title, video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
//    
//    func getTitle() -> String? {
//        return title
//    }
//    
//    func getMediaType() -> MediaType {
//        return .movie
//    }
//}
//

