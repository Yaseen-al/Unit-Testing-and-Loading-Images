//
//  MovieSearchTableViewController.swift
//  UITesting-TableView-Image-Loading
//
//  Created by Yaseen Al Dallash on 4/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController , UIGestureRecognizerDelegate {
    var movies = [Movie](){
        didSet{
            tableView.reloadData()
        }
    }
    
    //MAKR: - NavBar Configuration
    private func setupNavigationBar(){
        let searchBar:UISearchBar = UISearchBar(frame: CGRect.zero)
        searchBar.placeholder = "Enter name of the movie"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tableView.addGestureRecognizer(tapGesture)
        tableView.register(MovieCustomTableViewCell.self, forCellReuseIdentifier: "movieCustomCell")
    }
    @objc func dismissKeyBoard(){
        navigationItem.titleView?.resignFirstResponder()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieSetup = movies[indexPath.row]
        guard let movieCustomCell = tableView.dequeueReusableCell(withIdentifier: "movieCustomCell") as? MovieCustomTableViewCell else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            print("error loadingCell")
            return cell
        }
        movieCustomCell.movieTitle.text = movieSetup.trackName
        movieCustomCell.movieDescription.text = movieSetup.longDescription
        movieCustomCell.movieImageView.image = nil
        ImageHelper.manager.getImage(from: movieSetup.artworkUrl100, completion: { (movieImage) in
            movieCustomCell.movieImageView.image = movieImage
            movieCustomCell.setNeedsDisplay()
            movieCustomCell.spinner.stopAnimating()
        }, errorHandler: {print($0)})
        return movieCustomCell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height*0.30
    }
}

//MARK: -TableView Delegate
extension MovieSearchTableViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentMovie = self.movies[indexPath.row]
        print(currentMovie.trackName)
        let detailMovieController = DetailMovieViewController.storyBoardInstance()
        self.navigationController?.pushViewController(detailMovieController, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension MovieSearchTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, searchBar.text != " " else {
            Alert.present(title: "Please enter a valid movie name", message: nil)
            return
        }
        MovieAPIClient.shared.searchMovies(keyword: searchText) { (error, movieResults) in
            if let error = error{
                Alert.present(title: "There was an error loading your movies\(error.localizedDescription)", message: nil)
            }
            if let movieResults = movieResults{
                self.movies = movieResults
            }
        }
        searchBar.resignFirstResponder()
    }
}
