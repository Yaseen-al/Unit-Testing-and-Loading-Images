//
//  MovieCustomTableViewCell.swift
//  UITesting-TableView-Image-Loading
//
//  Created by Yaseen Al Dallash on 4/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit

class MovieCustomTableViewCell: UITableViewCell {
    //MARK: - Properties
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var  movieTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    lazy var  movieDescription: UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        label.numberOfLines = 0
        return label
    }()
    lazy var spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    //MARK: - Inits
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Setup Views
    private func setupView(){
        setupMovieImageView()
        setupMovieTitle()
        setupMovieDescription()
        setupSpinner()
    }
    
    private func setupMovieImageView(){
        addSubview(movieImageView)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        movieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        movieImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
    }
    private func setupMovieTitle(){
        addSubview(movieTitle)
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        movieTitle.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 10).isActive = true
        movieTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    }
    private func setupMovieDescription(){
        addSubview(movieDescription)
        movieDescription.translatesAutoresizingMaskIntoConstraints = false
        movieDescription.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10).isActive = true
        movieDescription.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 10).isActive = true
        movieDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        movieDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    private func setupSpinner(){
        movieImageView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: movieImageView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor).isActive = true

    }
    
}









