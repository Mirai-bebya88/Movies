//
//  MoviesTableViewCell.swift
//  Movies
//
//  Created by elene malakmadze on 09.01.26.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var popularity: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with movie: Movie) {
        name.text = movie.name
        popularity.text = String(format: "%.1f", movie.popularity)
        
        let url = URL(string: "https://image.tmdb.org/t/p/w300\(movie.posterImage)")
        movieImage.kf.indicatorType = .activity
        movieImage.kf.setImage(with: url)
    }
}
