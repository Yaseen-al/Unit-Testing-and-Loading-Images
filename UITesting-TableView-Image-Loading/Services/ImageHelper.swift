//
//  ImageHelper.swift
//  UITesting-TableView-Image-Loading
//
//  Created by Yaseen Al Dallash on 4/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
import UIKit
//MARK: - Properties
class ImageHelper{
    //MARK: - Properties
    static let manager = ImageHelper()
    //MARK: - Inits
    private init(){}
    //MARK: - Public Functions
    public func getImage(from urlStr: String, completion: @escaping(UIImage)->Void, errorHandler: @escaping(Error)->Void){
        guard let url = URL.init(string: urlStr) else {
            errorHandler(NetworkServiceErrors.badURL)
            return
        }
        //Checking if there is an image saved in the cache
        if let image = NSCacheHelper.manager.retrieveImageFromCach(urlStr: urlStr){
            completion(image)
            return
        }
        let completion = {(data: Data) in
            guard let onlineImage = UIImage.init(data: data)else{
                errorHandler(NetworkServiceErrors.badData)
                return
            }
            completion(onlineImage)
            NSCacheHelper.manager.addImageToCache(image: onlineImage, urlStr: urlStr)
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: {errorHandler($0)})
    }
}
