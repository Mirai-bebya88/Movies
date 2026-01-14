//
//  MovieAPIManager.swift
//  Movies
//
//  Created by elene malakmadze on 09.01.26.
//


import Foundation

/*
 https://api.themoviedb.org/3/movie/top_rated?api_key=cc369969178d5bf3c9cc3c18d264a837
 */


protocol MovieAPIManagerProtocol {
    func fetchMovies(completion: @escaping (Result<MovieResponse, Error>) -> ())
}

class MovieAPIManager: MovieAPIManagerProtocol {
    func fetchMovies(completion: @escaping (Result<MovieResponse, any Error>) -> ()) {
        NetworkManager.shared.get(
            urlString: "https://api.themoviedb.org/3/movie/top_rated?api_key=cc369969178d5bf3c9cc3c18d264a837",
            completion: completion
        )
    }
}
