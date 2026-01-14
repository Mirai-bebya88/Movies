//
//  MoviesViewController.swift
//  Movies
//
//  Created by elene malakmadze on 09.01.26.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = MoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        setupViewModel()
        viewModel.fetchMovies()
    }
    
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(
            UINib(nibName: "MoviesTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MoviesTableViewCell"
        )
    }
    

    private func setupViewModel() {
            viewModel.delegate = self
        }
}

extension MoviesViewController: MoviesViewModelDelegate {
    func moviesDidUpdate() {
        tableView.reloadData()
    }
    
    func moviesDidFail(error: Error) {
        print("Error fetching movies: \(error)")
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        cell.configure(with: viewModel.movie(at: indexPath.row))
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "MoviesDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MoviesDetailViewController") as! MoviesDetailViewController
        vc.setMovie(viewModel.movie(at: indexPath.row))
        navigationController?.pushViewController(vc, animated: true)
    }
}
