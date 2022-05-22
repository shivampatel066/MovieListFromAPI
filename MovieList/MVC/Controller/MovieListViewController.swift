//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Shivam Patel on 22/05/22.
//

import UIKit

class MovieListViewController: UIViewController {
    
    
    
    @IBOutlet weak var moviesTableView: UITableView!
    var moviesList:[MovieModel] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIHelper.shareInstance.apiCalling { moviesList in
            self.moviesList = moviesList
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }
}

// MARK: TableView Delegate/Datasource Methods.
extension MovieListViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.movieObject = moviesList[indexPath.row]
        cell.configureUI()
        return cell
    }
}

extension MovieListViewController:UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
