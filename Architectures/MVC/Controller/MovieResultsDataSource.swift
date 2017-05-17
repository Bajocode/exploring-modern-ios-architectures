//
//  MovieResultsDataSource.swift
//  Architectures
//
//  Created by Fabijan Bajo on 17/05/2017.
//
//

import UIKit

class MovieResultsDataSource: NSObject, UICollectionViewDataSource {
    
    
    // MARK: - Properties
    
    var movies = [Movie]()
    private let cellID = "MovieCell"
    
    
    // MARK: - DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MovieCollectionViewCell
        return cell
    }
}
