//
//  DetailMovieViewController.swift
//  UITesting-TableView-Image-Loading
//
//  Created by Yaseen Al Dallash on 5/21/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static public func storyBoardInstance() -> DetailMovieViewController {
        let storyBoard = UIStoryboard(name: "DetailMovieStoryBoard", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: "DetailMovieViewController") as! DetailMovieViewController
    }

}
