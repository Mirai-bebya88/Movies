//
//  FavoriteViewController.swift
//  Movies
//
//  Created by elene malakmadze on 09.01.26.
//

import UIKit

class FavoriteViewController: UIViewController {
    
   @IBOutlet private weak var tableView: UITableView!
    
    private var favourites: [FavouriteMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        fetchFavourites()
        
        CoreDataManager.shared.onFavouritesChanged = {[weak self] in
                    self?.fetchFavourites()
                }
    }
    

    private func setupTableView() {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(
                UINib(nibName: "MoviesTableViewCell", bundle: nil),
                forCellReuseIdentifier: "MoviesTableViewCell"
            )
        }
        
        private func fetchFavourites() {
            favourites = CoreDataManager.shared.fetchAllFavourites()
            tableView.reloadData()
        }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        cell.configure(with: favourites[indexPath.row])
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
