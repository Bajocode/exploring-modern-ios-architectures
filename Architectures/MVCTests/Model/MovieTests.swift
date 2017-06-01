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
    
    func test_Init_WhenGivenValues_SetsValues() {
        let movie = Movie(title: "Foo", thumbnailURL: URL(string: "Bar")!, fullURL: URL(string: "Baz")!, movieID: 1, releaseDate: "Qux", averageRating: "Quux")
        
        XCTAssertEqual(movie.title, "Foo")
        XCTAssertEqual(movie.thumbnailURL, URL(string: "Bar")!)
        XCTAssertEqual(movie.fullURL, URL(string: "Baz")!)
        XCTAssertEqual(movie.releaseDate, "Qux")
        XCTAssertEqual(movie.averageRating, "Quux")
    }
    
    
    
    // MARK: - Equatable
    
    func test_EqualMovies_AreEqual_WithSameIDs() {
        let first = Movie(title: "", thumbnailURL: URL(string: "Foo")!, fullURL: URL(string: "Foo")!, movieID: 1, releaseDate: "", averageRating: "")
        let second = Movie(title: "", thumbnailURL: URL(string: "Foo")!, fullURL: URL(string: "Foo")!, movieID: 1, releaseDate: "", averageRating: "")
        XCTAssertEqual(first, second)
    }
    func test_EqualMovies_AreUnEqual_WithDIfferentIDs() {
        let first = Movie(title: "", thumbnailURL: URL(string: "Foo")!, fullURL: URL(string: "Foo")!, movieID: 1, releaseDate: "", averageRating: "")
        let second = Movie(title: "", thumbnailURL: URL(string: "Foo")!, fullURL: URL(string: "Foo")!, movieID: 0, releaseDate: "", averageRating: "")
        XCTAssertNotEqual(first, second)
    }
}
