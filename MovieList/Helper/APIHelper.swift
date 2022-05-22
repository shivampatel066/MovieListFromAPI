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
    
    let baseURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(APIKeys.getApiKey())&language=en-US&page=1"
    
    func apiCalling(completionHandler: @escaping ([MovieModel]) -> ()){
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
}
