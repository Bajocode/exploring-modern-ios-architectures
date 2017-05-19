//
//  MovieViewModel.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import UIKit

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
    private let releaseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }()
    
    
    // MARK: - CellRepresentable
    
    var objectID: Int {
        return movie.movieID
    }
    var imageURL: URL {
        return TmdbAPI.tmdbImageURL(forSize: .thumb, path: movie.posterPath)
    }
    var cellID: String {
        return "MovieCell"
    }
    
    
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
    
    func updateCellImage(_ collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        DataManager.shared.imageManager.fetchImage(forVM: self, size: .thumb) { (result) in
            
            
            guard
                case let .success(image) = result,
                let movieCell = cell as? MovieCollectionViewCell else {
                return
            }
            
            movieCell.updateImageView(with: image)
        }
        
    }
}
