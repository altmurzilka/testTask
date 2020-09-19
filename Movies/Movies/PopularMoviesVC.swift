//
//  PopularMoviesVC.swift
//  Movies
//
//  Created by Алтын on 9/18/20.
//

import UIKit

private let identifier = "MovieCell"

class PopularMoviesVC: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var movies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.fetchPopularMovies { data in
            self.movies = data.results
            self.collectionView.reloadData()
        }
    }
    
    
}


extension PopularMoviesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    
}

