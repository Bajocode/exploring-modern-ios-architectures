//
//  MovieViewModel.swift
//  Architectures
//
//  Created by Fabijan Bajo on 16/05/2017.
//
//

import UIKit

struct CellProportion {
    let heightDivisor: CGFloat
    let widthDivisor: CGFloat
    let spacing: CGFloat
}


class MovieViewModel {
    
    
    // MARK: - Properties
    
    let movie: Movie
    var releaseDate: String {
        return releaseDateFormatter.string(from: movie.releaseDate)
    }
    var rating: String {
        return String(format: "%.1f", movie.averageRating)
    }
    private let cellID = "MovieCell"
    var proportion: CellProportion {
        return CellProportion( heightDivisor: 2.5,
                               widthDivisor: 2,
                               spacing: 1)
    }    
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
