//
//  Results.swift
//  Movies
//
//  Created by Алтын on 9/18/20.
//

import Foundation

struct Results: Codable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
}
