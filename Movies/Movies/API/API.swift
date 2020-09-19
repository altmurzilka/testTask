//
//  API.swift
//  Movies
//
//  Created by Алтын on 9/18/20.
//

import Foundation
import Alamofire

private let baseURL = "https://api.themoviedb.org/3/movie/"
let posterURL = "https://image.tmdb.org/t/p/original"
private let apiKey = "3d19363f85ab4a409c9fb1d53e5b61e3"

private let coder = JSONDecoder()

class API {
    class func fetchPopularMovies(_ onSuccess: @escaping(Results) -> Void) {
        coder.keyDecodingStrategy = .convertFromSnakeCase
        let urlStr = "\(baseURL)popular?api_key=\(apiKey)"
        guard let url = URL(string: urlStr) else { fatalError("Unable to get URL")}
        
        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { fatalError("Unable to parse data from api") }
                guard let results = try? coder.decode(Results.self, from: data) else { fatalError("Unable to parse data into JSON")}
                DispatchQueue.main.async {
                    onSuccess(results)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
