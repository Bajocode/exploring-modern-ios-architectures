//
//  MovieViewModel.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import UIKit

struct MovieViewModel {
    
    
    // MARK: - Properties
    
    let movie: Movie
    var releaseDate: String {
        let dateObject = releaseDateFormatter.date(from: movie.releaseDate)
        return releaseDateFormatter.string(from: dateObject!)
    }
    var rating: String {
        return String(format: "%.1f", movie.averageRating)
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
}


// MARK: - DetailRepresentable

extension MovieViewModel: DetailRepresentable {
    
    // Properties
    var fullImageURL: URL {
        return TmdbAPI.tmdbImageURL(forSize: .full, path: movie.posterPath)
    }
    
    // Methods
    func updateFullImage(completion: @escaping (_ image: UIImage) -> Void) {
        DataManager.shared.imageManager.fetchImage(with: fullImageURL) { (result) in
            switch result {
            case let .success(image):
                completion(image)
            case let .failure(error):
                print(error)
            }
        }
    }
}


// MARK: - CellRepresentable

extension MovieViewModel: CellRepresentable {
    
    // Properties
    var objectID: Int {
        return movie.movieID
    }
    var thumbImageURL: URL {
        return TmdbAPI.tmdbImageURL(forSize: .thumb, path: movie.posterPath)
    }
    var cellID: String {
        return "MovieCell"
    }
    var cornerRadius: CGFloat? {
        return nil
    }
    
    // Methods
    func cellSize(withBounds bounds: CGRect) -> CGSize {
        let width = (bounds.width - 1) / 2
        let height = (bounds.height - 1) / 2.5
        return CGSize(width: width, height: height)
    }
    
    func cellInstance(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        // Instantiate
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MovieCollectionViewCell
        // Setup cell with self and return
        cell.configure(with: self)
        return cell
    }
    
    func updateCellImage(_ collectionView: UICollectionView,  cell: UICollectionViewCell, indexPath: IndexPath) {
        DataManager.shared.imageManager.fetchImage(with: thumbImageURL) { (result) in
            
            // Make sure it's the same movie object (fetching async)
            guard
                case let .success(image) = result,
                let movieCell = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell else {
                    return
            }
            // Update cell when image request finishes, if cell still visible on screen
            movieCell.updateImageView(with: image, cornerRadius: self.cornerRadius)
        }
    }
}
