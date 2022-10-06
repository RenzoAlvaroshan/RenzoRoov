//
//  Movie.swift
//  RenzoRoov
//
//  Created by Renzo Alvaroshan on 04/10/22.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String?
    let posterPath: String?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
    }
}
