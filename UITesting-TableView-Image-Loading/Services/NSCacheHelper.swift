//
//  NSCacheHelper.swift
//  UITesting-TableView-Image-Loading
//
//  Created by Yaseen Al Dallash on 4/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
import UIKit

class NSCacheHelper{
    //MARK: - Properties
    static let manager = NSCacheHelper()
    private var imageCache = NSCache<NSString, UIImage>()
    //MARK: - Inits
    private init(){}
    //MARK: - Public Functions
    public func addImageToCache(image: UIImage, urlStr: String){
        self.imageCache.setObject(image, forKey: urlStr as NSString)
    }
    public func retrieveImageFromCach(urlStr: String)->UIImage?{
        return self.imageCache.object(forKey: urlStr as NSString)
    }
    
}
