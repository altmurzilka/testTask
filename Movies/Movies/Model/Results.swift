//
//  Results.swift
//  Movies
//
//  Created by Алтын on 9/18/20.
//

import Foundation

struct Results: Codable {
    let page: Int
    let totalResults: Int?
    let totalPages: Int?
    let results: [Movie]
}
