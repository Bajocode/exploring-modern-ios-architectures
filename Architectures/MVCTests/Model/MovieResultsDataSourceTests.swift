//
//  MovieResultsDataSourceTests.swift
//  Architectures
//
//  Created by Fabijan Bajo on 21/05/2017.
//
//

import XCTest
@testable import MVC

class MovieResultsDataSourceTests: XCTestCase {
    
    
    // MARK: - Properties
    
    // System under test
    var sut: MovieResultsDataSource!
    var movieResultsVC: MovieResultsViewController!
    var collectionView: UICollectionView!
    
    
    // MARK: - Related to every test
    
    override func setUp() {
        super.setUp()
        // Configure sut
        sut = MovieResultsDataSource()
        movieResultsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieResultsVC") as! MovieResultsViewController
        movieResultsVC.movieManager = MovieManager()
        // Trigger viewDidLoad to initialize @IBOutlets
        _ = movieResultsVC.view
        // Configure collectionView
        collectionView = movieResultsVC.collectionView
        collectionView.dataSource = sut
        collectionView.delegate = movieResultsVC
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK: - Datasource
    
    func test_NumberOfItems_IsMoviesCount() {
        sut.movies.append(Movie(title: "", posterPath: "", movieID: 0, releaseDate: Date(), averageRating: 0.0))
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 1)
    }
    
    func test_CellforRow_ReturnsMovieCell() {
//        sut.movies.append(Movie(title: "", posterPath: "", movieID: 0, releaseDate: Date(), averageRating: 0.0))
//        collectionView.reloadData()
//        let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0))
//        XCTAssertTrue(cell is MovieCollectionViewCell)
    }
    
}
