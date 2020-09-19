//
//  ViewController.swift
//  MovieAppTestTask
//
//  Created by Алтын on 9/19/20.
//

import UIKit
import Foundation


final class MoviesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var movies = [Movie]()
    fileprivate var nextPage = 2
    
    fileprivate struct TableViewCellIdentifiers{
        static var movie = "MovieCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getTopMovies()
    }
    
    // MARK: Services
    fileprivate func getTopMovies(page : Int = 1){
        WebApi.instance.getTopMovies(page: page)  { [weak self] (movies, webResponse) in
            if !webResponse.isError{
                
                if movies.count < 20{
                    self?.stopPagination()
                }
                
                self?.movies = self!.mergeMovies(currentMovies: self!.movies, newMovies: movies, page: page)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            }
        }
    }
    
    private func mergeMovies(currentMovies : [Movie], newMovies : [Movie], page : Int) -> [Movie]{
        if page == 1{
            return newMovies
        }else{
            return currentMovies + newMovies
        }
    }
    
    // MARK: Pagination methods
    fileprivate func resetPagination(){
        nextPage = 2
    }
    
    fileprivate func stopPagination(){
        nextPage = -1
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            let movieDetailViewController = segue.destination as! MovieDetailViewController
            guard let row = tableView.indexPathForSelectedRow?.row else { return }
            movieDetailViewController.movie = movies[row]
        }
    }
    
}


// MARK: TableViewDelegate & DataSource
extension MoviesViewController : UITableViewDelegate, UITableViewDataSource{
    
    fileprivate func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.movie)
        tableView.estimatedRowHeight = 187
        tableView.rowHeight = UITableView.automaticDimension
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.movie) as! MovieTableViewCell
        cell.fill(movie: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if nextPage == -1{
            return
        }
        
        if indexPath.row == movies.count - 1{
            nextPage += 1
        }
        
    }
    
}
