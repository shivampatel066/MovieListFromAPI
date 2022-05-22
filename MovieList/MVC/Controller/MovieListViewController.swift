//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Shivam Patel on 22/05/22.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    var moviesList:[MovieModel] = [] {
        didSet{
            displayList = self.moviesList
        }
    }
    var displayList:[MovieModel] = []
    
    let movieAPIURL = "http://api.themoviedb.org/3/movie/popular?api_key=\(APIKeys.getApiKey())&language=en-US&page=1"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchConfiguration()
        APIHelper.shareInstance.getMoviesFromAPI(baseURL:movieAPIURL) { moviesList in
            self.moviesList = moviesList
            DispatchQueue.main.async {
                if self.moviesList.count > 0 {
                    self.moviesTableView.isHidden = false
                } else {
                    self.moviesTableView.isHidden = true
                }
                self.moviesTableView.reloadData()
            }
        }
        
    }
    
    func searchConfiguration(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        self.title = "Movies"
    }
}

// MARK: TableView Datasource Methods.
extension MovieListViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.movieObject = displayList[indexPath.row]
        cell.configureUI()
        return cell
    }
}

// MARK: TableView Delegate Methods.
extension MovieListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
            vc.movieObject = displayList[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//Search Updation Delegate
extension MovieListViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else { return }
        if searchString.isEmpty{
            self.displayList = self.moviesList
        }else{
            self.displayList = self.moviesList.filter{
                $0.title.lowercased().contains(searchString.lowercased())
            }
        }
        DispatchQueue.main.async {
            if self.displayList.count > 0 {
                self.moviesTableView.isHidden = false
            } else {
                self.moviesTableView.isHidden = true
            }
        }
        self.moviesTableView.reloadData()
    }
    
}
