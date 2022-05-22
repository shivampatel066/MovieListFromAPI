//
//  APIKey.swift
//  MovieList
//
//  Created by Shivam Patel on 22/05/22.
//

import Foundation

class APIKeys {
    fileprivate static let secretAPIKey:String = "878c78c15e71a1cb8c70ebb75fda441e"
    static func getApiKey() -> String {
        return self.secretAPIKey
    }
}
