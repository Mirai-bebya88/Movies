//
//  MoviesViewController.swift
//  Movies
//
//  Created by elene malakmadze on 09.01.26.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var apiManager: MovieAPIManagerProtocol?
    private var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchMovies()
        setUpTableView()
       
    }
    
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.layer.backgroundColor = UIColor.black.cgColor
        tableView.dataSource = self
        
        tableView.register(
            UINib(nibName: "MoviesTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MoviesTableViewCell"
        )
    }
    

    private func fetchMovies() {
        apiManager = MovieAPIManager()
        
            apiManager?.fetchMovies { result in
                switch result {
                case .success(let movieResponse):
                    self.movies = movieResponse.movies
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error fetching movies: \(error)")
                }
            }
        }

}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let sb = UIStoryboard(name: "MoviesDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MoviesDetailViewController") as! MoviesDetailViewController
        vc.setMovie(movies[indexPath.row]) 
        navigationController?.pushViewController(vc, animated: true)
    }
}
