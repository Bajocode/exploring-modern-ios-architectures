//
//  MovieTests.swift
//  Architectures
//
//  Created by Fabijan Bajo on 20/05/2017.
//
//

import XCTest
@testable import MVC

class MovieTests: XCTestCase {
    
    
    // MARK: - Related to every test
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK: - Initialization
    
    func test_Init_WhenGivenTitle_SetsTitle() {
        let movie = Movie(title: "Foo", posterPath: "", movieID: 0, releaseDate: Date(), averageRating: 0.0)
        XCTAssertEqual(movie.title, "Foo")
    }
    func test_Init_WhenGivenPosterPath_SetsPosterPath() {
        let movie = Movie(title: "", posterPath: "Foo", movieID: 0, releaseDate: Date(), averageRating: 0.0)
        XCTAssertEqual(movie.posterPath, "Foo")
    }
    func test_Init_WhenGivenID_SetsID() {
        let movie = Movie(title: "", posterPath: "", movieID: 1, releaseDate: Date(), averageRating: 0.0)
        XCTAssertEqual(movie.movieID, 1)
    }
    func test_Init_WhenGivenReleaseDate_SetsReleaseDate() {
        let dateNow = Date()
        let movie = Movie(title: "", posterPath: "", movieID: 0, releaseDate: dateNow, averageRating: 0.0)
        XCTAssertEqual(movie.releaseDate, dateNow)
    }
    func test_Init_WhenGivenRating_SetsRating() {
        let movie = Movie(title: "", posterPath: "", movieID: 0, releaseDate: Date(), averageRating: 1.0)
        XCTAssertEqual(movie.averageRating, 1.0)
    }
    
}
