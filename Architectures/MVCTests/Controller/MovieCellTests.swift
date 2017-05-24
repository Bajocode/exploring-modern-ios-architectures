//
//  MovieCellTests.swift
//  Architectures
//
//  Created by Fabijan Bajo on 24/05/2017.
//
//

import XCTest
@testable import MVC

class MovieCellTests: XCTestCase {
    
    
    // MARK: - Properties
    
    // System under test
    var sut: MovieCollectionViewCell!
    var collectionView: UICollectionView!
    let fakeDS = FakeDataSource()
    
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        // Instantiate vc and trigger view did load
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieResultsVC") as! MovieResultsViewController
        vc.movieManager = MovieManager()
        _ = vc.view
        
        // Get reference to collectionview and configure sut
        collectionView = vc.collectionView
        collectionView.dataSource = fakeDS
        sut = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: IndexPath(item: 0, section: 0)) as! MovieCollectionViewCell
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    /*
        MVC testing bottleneck
        - Tight coupledness of View and Controller
        - Triggering viewdidload, also triggers other MovieResultsVC events, making the test pass, but then crash
    */
    func test_hasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
    }
    func test_hasRatingLabel() {
        XCTAssertNotNil(sut.ratingLabel)
    }
    func test_ConfigCell_SetsLabelTexts() {
        sut.configure(withTitle: "Foo", rating: "Bar")
        XCTAssertEqual(sut.titleLabel.text, "Foo")
        XCTAssertEqual(sut.ratingLabel.text, "Bar")
    }
}


// MARK: - FakeDataSource

extension MovieCellTests {
    class FakeDataSource: NSObject, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return UICollectionViewCell()
        }
    }
}
