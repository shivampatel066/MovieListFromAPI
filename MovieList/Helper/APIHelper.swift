//
//  APIHelper.swift
//  MovieList
//
//  Created by Shivam Patel on 22/05/22.
//

import Foundation
import UIKit

class APIHelper{
    
    static let shareInstance = APIHelper()
    
    func getMoviesFromAPI(baseURL:String,completionHandler: @escaping ([MovieModel]) -> ()){
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let jsonResponse = try JSONDecoder().decode(Result.self, from: data)
                completionHandler(jsonResponse.results)
            } catch  {
                print(error)
            }
        }.resume()
    }
    
    func getCreditsFromAPI(baseURL:String,completionHandler: @escaping ([Cast]) -> ()){
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let jsonResponse = try JSONDecoder().decode(CreditResult.self, from: data)
                //let jsonResponse = try JSONDecoder().decode(CreditResult.self, from: data)
                completionHandler(jsonResponse.cast)
            } catch  {
                print(error)
            }
        }.resume()
    }
    func getGenreFromAPI(baseURL:String,completionHandler: @escaping ([Genre]) -> ()){
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let jsonResponse = try JSONDecoder().decode(GenreResult.self, from: data)
                completionHandler(jsonResponse.genres)
            } catch  {
                print(error)
            }
        }.resume()
    }

}
