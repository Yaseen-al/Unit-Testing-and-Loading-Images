//
//  MovieAPIClient.swift
//  UITesting-TableView-Image-Loading
//
//  Created by Yaseen Al Dallash on 4/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
struct MovieAPIClient {
    //MARK: - Properties
    static let shared = MovieAPIClient()
    //MARK: - Inits
    private init() {}
    //MARK: - Public Functions
    public func searchMovies(keyword: String, completion: @escaping (Error? ,[Movie]?) -> Void) {
        let keyWordIntoUrlFormate = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let apiStr = "https://itunes.apple.com/search?media=movie&term=\(keyWordIntoUrlFormate ?? keyword)&limit=100"
        guard let url = URL.init(string: apiStr) else{
            completion(NetworkServiceErrors.badURL, nil)
            return
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: { (data) in
            do{
                let moviesSearch = try JSONDecoder().decode(MovieSearch.self, from: data)
                completion(nil, moviesSearch.results)
            }catch{
                completion(error, nil)
            }
        }, errorHandler: {completion($0,nil)})
    }
}
