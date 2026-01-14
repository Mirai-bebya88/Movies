//
//  MoviesViewModel.swift
//  Movies
//
//  Created by elene malakmadze on 14.01.26.
//

import Foundation

protocol MoviesViewModelDelegate: AnyObject {
    func moviesDidUpdate()
    func moviesDidFail(error: Error)
}

class MoviesViewModel {
    
    weak var delegate: MoviesViewModelDelegate?
    
    private let apiManager: MovieAPIManagerProtocol
    private(set) var movies: [Movie] = []
    
    var numberOfMovies: Int {
        movies.count
    }
    
    init(apiManager: MovieAPIManagerProtocol = MovieAPIManager()) {
        self.apiManager = apiManager
    }
    
    func fetchMovies() {
        apiManager.fetchMovies { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.movies = movieResponse.movies
                self?.delegate?.moviesDidUpdate()
            case .failure(let error):
                self?.delegate?.moviesDidFail(error: error)
            }
        }
    }
    
    func movie(at index: Int) -> Movie {
        movies[index]
    }
}
