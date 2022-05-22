//
//  MovieModel.swift
//  MovieList
//
//  Created by Shivam Patel on 22/05/22.
//

import Foundation

struct CreditResult: Codable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Codable {

    let name, originalName: String
    let character: String?

    
    enum CodingKeys: String, CodingKey {

        case name
        case originalName = "original_name"
        case character
    }
}

enum KnownForDepartment: String, Codable {
    case acting = "Acting"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}
