//
//  MovieViewModel.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import UIKit

struct CellProportion {
    let heightDivisor: CGFloat
    let widthDivisor: CGFloat
    let spacing: CGFloat
}

struct MovieViewModel: CellRepresentable {
    
    
    // MARK: - Properties
    
    let movie: Movie
    var releaseDate: String {
        return releaseDateFormatter.string(from: movie.releaseDate)
    }
    var rating: String {
        return String(format: "%.1f", movie.averageRating)
    }
    var cellProportion: CellProportion {
        return CellProportion( heightDivisor: 2.5,
                               widthDivisor: 2,
                               spacing: 1)
    }
    
    // CellRepresentable
    var objectID: Int {
        return movie.movieID
    }
    var imageURL: URL {
        return TmdbAPI.tmdbImageURL(forSize: .thumb, path: movie.posterPath)
    }

    
    // Private
    private let cellID = "MovieCell"
    private let releaseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }()
    
    
    // MARK: - Initializers
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    
    // MARK: - Methods
    
    func cellInstance(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        // Instantiate
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MovieCollectionViewCell
        
        // Setup cell with self and return
        cell.configure(with: self)
        return cell
    }
}
