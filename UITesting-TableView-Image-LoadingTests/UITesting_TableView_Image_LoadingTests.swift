//
//  UITesting_TableView_Image_LoadingTests.swift
//  UITesting-TableView-Image-LoadingTests
//
//  Created by Yaseen Al Dallash on 4/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import XCTest
@testable import UITesting_TableView_Image_Loading

class UITesting_TableView_Image_LoadingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMoviewAPIClient(){
        let myExpectaion = expectation(description: "Movie Results received")
        var movies = [Movie]()
        MovieAPIClient.shared.searchMovies(keyword: "Sam") { (error, movieResults) in
            if let error = error{
                XCTFail(error.localizedDescription)
            }
            if let movieResults = movieResults{
                myExpectaion.fulfill()
                movies = movieResults
            }
        }
        wait(for: [myExpectaion], timeout: 3.0)
        XCTAssertGreaterThan(movies.count, 0, "movies count should be greate than 0")
    }
    
    func testMoviewAPIClientUnrated(){
        let myExpectaion = expectation(description: "Movie Results received")
        var movies = [Movie]()
        MovieAPIClient.shared.searchMovies(keyword: "Comedy") { (error, movieResults) in
            if let error = error{
                XCTFail(error.localizedDescription)
            }
            if let movieResults =  movieResults{
                movies = movieResults.filter{$0.contentAdvisoryRating == "Unrated"}

                myExpectaion.fulfill()
            }
        }
        wait(for: [myExpectaion], timeout: 10)
        XCTAssertGreaterThan(movies.count, 0, "Unrated movies count should be greate than 0")
    }
    
}
