//
//  MovieResponse.swift
//  Movies
//
//  Created by elene malakmadze on 14.01.26.
//

struct MovieResponse: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
