//
//  ModelTests.swift
//  Architectures
//
//  Created by Fabijan Bajo on 02/06/2017.
//
//

import XCTest
@testable import VIPER

class ModelTests: XCTestCase {
    
    
    // MARK: - Configuration
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    

    // MARK: - Initializers
    
    func test_Init_WhenGivenValues_SetsValues() {
        let movie = Movie(title: "Foo", posterPath: "Bar", movieID: 0, releaseDate: "Baz", averageRating: 1.0)
        
        XCTAssertEqual(movie.title, "Foo")
        XCTAssertEqual(movie.posterPath, "Bar")
        XCTAssertEqual(movie.movieID, 0)
        XCTAssertEqual(movie.releaseDate, "Baz")
        XCTAssertEqual(movie.averageRating, 1.0)
    }
    
    
    // MARK: - Equatable
    
    func test_EqualMovies_AreEqual_WithSameIDs() {
        let first = Movie(title: "", posterPath: "", movieID: 0, releaseDate: "", averageRating: 0.0)
        let second = Movie(title: "", posterPath: "", movieID: 0, releaseDate: "", averageRating: 0.0)
        XCTAssertEqual(first, second)
    }
    func test_EqualMovies_AreUnEqual_WithDIfferentIDs() {
        let first = Movie(title: "", posterPath: "", movieID: 0, releaseDate: "", averageRating: 0.0)
        let second = Movie(title: "", posterPath: "", movieID: 1, releaseDate: "", averageRating: 0.0)
        XCTAssertNotEqual(first, second)
    }
    
}

