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
    
    private var viewModel: MoviesDetailViewModel?
    
    func setMovie(_ movie: Movie) {
        viewModel = MoviesDetailViewModel(movie: movie)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        viewModel.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else { return }
        
        movieLabel.text = viewModel.movieName
        releaseDateLabel.text = viewModel.releaseDate
        updateFavouriteButton(isFavourite: viewModel.isFavourite)
    }
    
    private func updateFavouriteButton(isFavourite: Bool) {
        let imageName = isFavourite ? "heart.fill" : "heart"
        let image = UIImage(systemName: imageName)
        favouriteButton.setImage(image, for: .normal)
        favouriteButton.tintColor = isFavourite ? .red : .gray
    }
    
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        viewModel?.toggleFavourite()
    }
}

extension MoviesDetailViewController: MoviesDetailViewModelDelegate {
    func favouriteStatusDidChange(isFavourite: Bool) {
        updateFavouriteButton(isFavourite: isFavourite)
    }
}
