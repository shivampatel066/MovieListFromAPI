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
    
    let movieAPIURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(APIKeys.getApiKey())&language=en-US&page=1"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIHelper.shareInstance.getMoviesFromAPI(baseURL:movieAPIURL) { moviesList in
            self.moviesList = moviesList
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }
}

// MARK: TableView Datasource Methods.
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

// MARK: TableView Delegate Methods.
extension MovieListViewController:UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
            vc.movieObject = moviesList[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
