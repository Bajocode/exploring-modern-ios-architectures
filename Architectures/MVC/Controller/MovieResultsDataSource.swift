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
        let movie = movies[indexPath.row]
        
        // Download the image data for only the cells that the user is attempting to view.
        // collectionView(_:willDisplay:forItemAt:), called every time a cell is getting displayed onscreen.
        // Add fetch completed movie data here
        cell.configure(withTitle: movie.title, rating: String(format: "%.1f", movie.averageRating))
        return cell
    }
}
