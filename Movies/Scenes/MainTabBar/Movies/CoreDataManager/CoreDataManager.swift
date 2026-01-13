//
//  CoreDataManager.swift
//  Movies
//
//  Created by elene malakmadze on 13.01.26.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    var context: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    
    
    func addToFavourites(movie: Movie) {
        guard let context = context else { return }
        
        let favourite = FavouriteMovie(context: context)
            favourite.id = Int32(movie.id)
            favourite.name = movie.name
            favourite.releaseDate = movie.releaseDate
            favourite.posterImage = movie.posterImage
            favourite.popularity = movie.popularity
            favourite.adult = movie.adult
        
        do {
            try context.save()
            print("Saved to favourites")
        } catch {
            print("Error saving favourite: \(error)")
        }
    }
    
    func removeFromFavourites(movie: Movie) {
        guard let context = context else { return }
        
        let request: NSFetchRequest<FavouriteMovie> = FavouriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movie.id)
        
        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            try context.save()
            print("Removed from favourites")
        } catch {
            print("Error removing favourite: \(error)")
        }
    }
    
    func isFavourite(movie: Movie) -> Bool {
        guard let context = context else { return false }
        
        let request: NSFetchRequest<FavouriteMovie> = FavouriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movie.id)
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Error checking favourite: \(error)")
            return false
        }
    }
    
    func fetchAllFavourites() -> [FavouriteMovie] {
        guard let context = context else { return [] }
        
        let request: NSFetchRequest<FavouriteMovie> = FavouriteMovie.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching favourites: \(error)")
            return []
        }
    }
}
