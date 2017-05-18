//
//  MovieResultsViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 16/05/2017.
//
//

import UIKit

class MovieResultsViewController: UIViewController {

    
    // MARK: - Properties
    
    @IBOutlet var collectionView: UICollectionView!
    var movieViewModels = [MovieViewModel]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}


// MARK: - CollectionViewDataSource

// Could separate further, but this feels more organized and contained 
extension MovieResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return movieViewModels[indexPath.item].cellInstance(collectionView, indexPath: indexPath)
    }
}

// MARK: - CollectionViewDelegate

extension MovieResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let movie = movieViewModels[indexPath.item].movie
        
        // Download image data for cell asynchronously
        ImageManager.fetchImage(forMovie: movie, size: .thumb) { (result) in
            print("Called fetchImage")
            
            // Make sure that we are dealing with same movie object (fetching takes time)
            guard
                let movieIndex = self.movieViewModels.index(where: { $0.movie == movie}),
                case let.success(image) = result else {
                return
            }
            let movieIndexPath = IndexPath(row: movieIndex, section: 0)
            
            // Update cell when image request finishes, if cell still visible on screen
            if let cell = self.collectionView.cellForItem(at: movieIndexPath) as? MovieCollectionViewCell {
                cell.updateImageView(with: image)
            }
        }
    }
}

// MARK: - CollectionViewDelegateFlowLayout

extension MovieResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard !movieViewModels.isEmpty else {
            return CGSize.zero
        }
        let proportion = movieViewModels[indexPath.item].proportion
        let width = (view.bounds.width - proportion.spacing) / proportion.widthDivisor
        let height = (view.bounds.height - proportion.spacing) / proportion.heightDivisor
        
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard !movieViewModels.isEmpty else {
            return 0.0
        }
        return movieViewModels[section].proportion.spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard !movieViewModels.isEmpty else {
            return 0.0
        }
        return movieViewModels[section].proportion.spacing
    }
}
