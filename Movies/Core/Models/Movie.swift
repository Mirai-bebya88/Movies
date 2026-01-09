//
//  Movie.swift
//  Movies
//
//  Created by elene malakmadze on 09.01.26.
//


struct MovieResponse: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    let name: String
    let popularity: Double
    let posterImage: String
    let adult: Bool
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case name = "original_title"
        case popularity, adult
        case posterImage = "poster_path"
        case releaseDate = "release_date"
    }
}
