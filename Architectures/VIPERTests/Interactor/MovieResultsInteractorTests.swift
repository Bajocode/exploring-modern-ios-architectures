//
//  MovieResultsInteractorTests.swift
//  Architectures
//
//  Created by Fabijan Bajo on 03/06/2017.
//
//

import XCTest
@testable import VIPER

class MovieResultsInteractorTests: XCTestCase {
    
    
    // MARK: - Properties
    
    var interactor: MovieResultsInteractor!
    
    
    // MARK: - Configuration
    
    override func setUp() {
        super.setUp()
        interactor = MovieResultsInteractor()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Subscripting viewmodel outputs presentable instance struct
    func test_RepresentableInstance_ConvertsCorrectly() {
        let movie = Movie(title: "Foo", posterPath: "path1", movieID: 0, releaseDate: "2017-03-23", averageRating: 8.0)
        let presentableMovie = interactor.presentableInstance(object: movie) as! MovieResultsInteractor.PresentableInstance
        XCTAssertEqual(presentableMovie.title, "Foo")
        XCTAssertEqual(presentableMovie.fullSizeURL, URL(string: "https://image.tmdb.org/t/p/original/path1")!)
        XCTAssertEqual(presentableMovie.thumbnailURL, URL(string:"https://image.tmdb.org/t/p/w300/path1")!)
        XCTAssertEqual(presentableMovie.releaseDateText, "2017-03-23")
        XCTAssertEqual(presentableMovie.ratingText, "8.0")
    }
    
}
