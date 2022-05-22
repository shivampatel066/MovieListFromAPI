//
//  MovieDetailsViewController.swift
//  MovieList
//
//  Created by Shivam Patel on 22/05/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var moviePicImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    
    
    var movieObject:MovieModel?
    var creditList:[Cast]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movieObject = movieObject {
            // The Cast of the movie is not provided in the movie object, checked in postman application, so I am fetching for individual movie again.
            let creditAPIURL = "https://api.themoviedb.org/3/movie/\(movieObject.id)/credits?api_key=\(APIKeys.getApiKey())&language=en-US"
            // For Genre Names to get from genreIds.
            let genreAPIURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=878c78c15e71a1cb8c70ebb75fda441e&language=en-US"
            
            //Calling API Functions to fetch appropriate stuffs
            getCreditFromAPI(creditAPIURL,movieObject: movieObject)
            getGenreFromAPI(genreAPIURL,movieObject: movieObject)
        }
        
        
        configureUI()
    }
    
    func getGenreFromAPI(_ genreAPIURL:String,movieObject:MovieModel) {
        APIHelper.shareInstance.getGenreFromAPI(baseURL: genreAPIURL) { genreList in
            var list:[String] = []
            for id in movieObject.genreIDS {
                let temp = genreList.filter { $0.id == id}
                if temp.count > 0 {
                    list.append(temp[0].name)
                }
            }
            if list.count > 0 {
                let genreString = list.joined(separator: ", ")
                DispatchQueue.main.async {
                    self.genresLabel.text = genreString
                }
            }
        }
    }
    
    func getCreditFromAPI(_ creditAPIURL:String,movieObject:MovieModel) {
        APIHelper.shareInstance.getCreditsFromAPI(baseURL: creditAPIURL) { creditList in
            self.creditList = creditList
            var creditString = ""
            for creditList in creditList {
                creditString += "\(creditList.name) - \(creditList.character ?? "")\n"
            }
            DispatchQueue.main.async {
                self.castLabel.text = creditString
            }
        }
    }
    
    func configureUI() {
        
        if let movieObject = movieObject {
            self.movieNameLabel.text = movieObject.title
            self.moviePicImageView.image = nil
            self.moviePicImageView.imageFromURL(urlString: "https://image.tmdb.org/t/p/original\(movieObject.posterPath)")
            self.ratingLabel.text = "★ \(movieObject.voteAverage) & \(movieObject.voteCount) votes"
            self.aboutLabel.text = movieObject.overview
            self.languageLabel.text = movieObject.originalLanguage.rawValue
            self.releaseDateLabel.text = getDateInCorrectFormat(date: movieObject.releaseDate)
        }
    }
}

//Utility func
extension MovieDetailsViewController {
    func getDateInCorrectFormat(date:String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy"
        
        if let tempDate = dateFormatterGet.date(from: date) {
            return (dateFormatterPrint.string(from: tempDate))
        }
        return ""
    }
}
