//
//  GenreModel.swift
//  MovieList
//
//  Created by Shivam Patel on 22/05/22.
//

import Foundation
struct GenreResult: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
