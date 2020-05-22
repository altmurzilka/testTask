//
//  Movie.swift
//  testTask
//
//  Created by алтынпончик on 5/23/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct MovieList: Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    var results : [Movie]
}

struct Movie: Identifiable, Decodable {
    var id : Int
    var original_title: String
    var vote_average: CGFloat
    var poster_path: String
    var original_language: String
    let title: String
    let release_date: String
    var overview: String
}

