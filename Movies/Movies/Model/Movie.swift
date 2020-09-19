//
//  Movie.swift
//  Movies
//
//  Created by Алтын on 9/18/20.
//

import Foundation

struct Movie: Codable, Identifiable {
    let voteCount: Int
    let id: Int
    let video: Bool
    let voteAverage: Double
    let title: String
    let popularity: Double
    let posterPath: String?
    let originalLanguage: String
    let originalTitle: String
    let backdropPath: String?
    let adult: Bool
    let overview: String
}
