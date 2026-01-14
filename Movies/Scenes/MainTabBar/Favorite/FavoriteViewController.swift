//
//  FavoriteViewController.swift
//  Movies
//
//  Created by elene malakmadze on 09.01.26.
//

import UIKit

class FavoriteViewController: UIViewController {
    
   @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = FavouriteViewModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupTableView()
            setupViewModel()
            viewModel.fetchFavourites()
        }

    private func setupTableView() {
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

extension FavoriteViewController: FavouriteViewModelDelegate {
    func favouritesDidUpdate() {
        tableView.reloadData()
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfFavourites
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        cell.configure(with: viewModel.favourite(at: indexPath.row))
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
