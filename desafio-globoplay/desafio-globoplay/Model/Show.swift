
import Foundation

struct TVShowResponse: Decodable {
    let results: [TVShow]
}

struct TVShow: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let poster_path: String?
    let overview: String?
    let first_air_date: String
    let vote_average: Double
//    var isFavorite: Bool = false

    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path ?? "")")
    }
}
