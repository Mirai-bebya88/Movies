//
//  MoviesDetailViewController.swift
//  Movies
//
//  Created by elene malakmadze on 09.01.26.
//

import UIKit

class MoviesDetailViewController: UIViewController {
    
    
    @IBOutlet private weak var movieLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var favouriteButton: UIButton!
    
    
    private var movie: Movie?
    private var isFavourite: Bool = false
    
    func setMovie(_ movie: Movie) {
            self.movie = movie
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie = movie else {
                    navigationController?.popViewController(animated: true)
                    return
                }
                
                setupUI(with: movie)
                checkFavouriteStatus(for: movie)
        
    }
    
    private func setupUI(with movie: Movie) {
        movieLabel.text = movie.name
            releaseDateLabel.text = "Release: \(movie.releaseDate)"
            }
        
        private func checkFavouriteStatus(for movie: Movie) {
            isFavourite = CoreDataManager.shared.isFavourite(movie: movie)
            updateFavouriteButton()
        }
        
        private func updateFavouriteButton() {
            let imageName = isFavourite ? "heart.fill" : "heart"
            let image = UIImage(systemName: imageName)
            favouriteButton.setImage(image, for: .normal)
            favouriteButton.tintColor = isFavourite ? .red : .gray
        }
    
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        guard let movie = movie else { return }
                
                if isFavourite {
                    CoreDataManager.shared.removeFromFavourites(movie: movie)
                } else {
    
                    CoreDataManager.shared.addToFavourites(movie: movie)
                }
                
                isFavourite.toggle()
                updateFavouriteButton()
            }
}
