//
//  FavoriteViewModel.swift
//  Movies
//
//  Created by elene malakmadze on 14.01.26.
//

import Foundation

protocol FavouriteViewModelDelegate: AnyObject {
    func favouritesDidUpdate()
}

class FavouriteViewModel {
    
    weak var delegate: FavouriteViewModelDelegate?
    
    private let coreDataManager: CoreDataManager
    private(set) var favourites: [FavouriteMovie] = []
    
    var numberOfFavourites: Int {
        favourites.count
    }
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
        setupObserver()
    }
    
    private func setupObserver() {
        coreDataManager.onFavouritesChanged = { [weak self] in
            self?.fetchFavourites()
        }
    }
    
    func fetchFavourites() {
        favourites = coreDataManager.fetchAllFavourites()
        delegate?.favouritesDidUpdate()
    }
    
    func favourite(at index: Int) -> FavouriteMovie {
        favourites[index]
    }
}
