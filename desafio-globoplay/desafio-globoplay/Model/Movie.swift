
import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Identifiable, Decodable, Hashable, Encodable {
    let id: Int
    let original_title: String
    let poster_path: String?
    let overview: String?
    let release_date: String
    let vote_average: Double
    
//    var isFavorite: Bool = false

    var posterURL: URL? {
        guard let poster_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path)")
    }
}

