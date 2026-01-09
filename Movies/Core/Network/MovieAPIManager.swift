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
        let urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=cc369969178d5bf3c9cc3c18d264a837"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
