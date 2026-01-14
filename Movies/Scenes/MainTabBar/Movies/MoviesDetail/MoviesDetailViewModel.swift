//
//  MoviesDetailViewModel.swift
//  Movies
//
//  Created by elene malakmadze on 14.01.26.
//

import Foundation

protocol MoviesDetailViewModelDelegate: AnyObject {
    func favouriteStatusDidChange(isFavourite: Bool)
}

class MoviesDetailViewModel {
    
    weak var delegate: MoviesDetailViewModelDelegate?
    
    private let movie: Movie
    private let coreDataManager: CoreDataManager
    
    private(set) var isFavourite: Bool = false
    
    var movieName: String {
        movie.name
    }
    
    var releaseDate: String {
        "Release: \(movie.releaseDate)"
    }
    
    init(movie: Movie, coreDataManager: CoreDataManager = .shared) {
        self.movie = movie
        self.coreDataManager = coreDataManager
        self.isFavourite = coreDataManager.isFavourite(movie: movie)
    }
    
    func toggleFavourite() {
        if isFavourite {
            coreDataManager.removeFromFavourites(movie: movie)
        } else {
            coreDataManager.addToFavourites(movie: movie)
        }
        
        isFavourite.toggle()
        delegate?.favouriteStatusDidChange(isFavourite: isFavourite)
    }
}
