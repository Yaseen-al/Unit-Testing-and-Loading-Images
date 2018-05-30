//
//  NetworkHelper.swift
//  UITesting-TableView-Image-Loading
//
//  Created by Yaseen Al Dallash on 4/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
 //MARK: - NetworkServiceErrors
enum NetworkServiceErrors: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case other(rawError: Error)
    case notAnImage
    case codingError(rawError: Error)
    case badData
    case urlError(rawError: Error)
}
class NetworkHelper {
    //MARK: - Properties
    static let manager = NetworkHelper()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    //MARK: - Inits
    private init() {
        // This will allow to cash the urls instead of calling it repetitively
        urlSession.configuration.requestCachePolicy = .returnCacheDataElseLoad
    }
    func performDataTask(with url: URL, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                // This will check if there is a request have done before or not
                let request = URLRequest(url: url)
                if let response = URLCache.shared.cachedResponse(for: request) {
                    completionHandler(response.data)
                    return
                }
                guard let data = data else {
                    errorHandler(NetworkServiceErrors.noDataReceived)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode != 401 else{
                    errorHandler(NetworkServiceErrors.badStatusCode)
                    return
                }
                if let error = error {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet{
                        errorHandler(NetworkServiceErrors.noInternetConnection)
                    }else{
                        errorHandler(NetworkServiceErrors.other(rawError: error))
                    }
                }
                completionHandler(data)
            }
            }.resume()
    }
}
