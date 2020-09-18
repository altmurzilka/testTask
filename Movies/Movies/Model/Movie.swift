//
//  Movie.swift
//  Movies
//
//  Created by Алтын on 9/18/20.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let backgroundPath: String
    let voteCount: Int
    let voteAvarage: Double
    let releaseDate: String
}
