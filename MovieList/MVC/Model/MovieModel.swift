//
//  MovieModel.swift
//  MovieList
//
//  Created by Shivam Patel on 22/05/22.
//

import Foundation

struct Result: Codable {
    let results: [MovieModel]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct MovieModel: Codable {
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let posterPath, releaseDate, title: String
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case fr = "fr"
}

