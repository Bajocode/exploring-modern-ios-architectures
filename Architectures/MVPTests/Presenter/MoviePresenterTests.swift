//
//  MoviePresenterTests.swift
//  Architectures
//
//  Created by Fabijan Bajo on 03/06/2017.
//
//

import XCTest
@testable import MVP

class MoviePresenterTests: XCTestCase {
    
    
    // MARK: - Properties
    
    var presenter: ResultsViewPresenter!
    
    
    // MARK: - Configuration
    
    override func setUp() {
        super.setUp()
        // Configure presenter with view
        let resultsVC = ResultsViewController()
        let movie = Movie(title: "Foo", posterPath: "path1", movieID: 0, releaseDate: "2017-03-23", averageRating: 8.0)
        presenter = MovieResultsPresenter(view: resultsVC, testableMovies: [movie])
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // Presenter outputs presentable instance struct
    func test_PresentableInstance_ConvertsCorrectly() {
        let presentableMovie = presenter.presentableInstance(index: 0) as! MovieResultsPresenter.PresentableInstance
        
        XCTAssertEqual(presentableMovie.title, "Foo")
        XCTAssertEqual(presentableMovie.fullSizeURL, URL(string: "https://image.tmdb.org/t/p/original/path1")!)
        XCTAssertEqual(presentableMovie.thumbnailURL, URL(string:"https://image.tmdb.org/t/p/w300/path1")!)
        XCTAssertEqual(presentableMovie.releaseDateText, "2017-03-23")
        XCTAssertEqual(presentableMovie.ratingText, "8.0")
    }
}
