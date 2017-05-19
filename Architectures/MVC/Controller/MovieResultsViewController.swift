//
//  MovieResultsViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import UIKit

class MovieResultsViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var movieManager: MovieManager!
    let dataSource = MovieResultsDataSource()
    @IBOutlet var collectionView: UICollectionView!
    fileprivate struct Storyboard {
        struct Segue {
            static let showDetailVC = "ShowDetailVC"
        }
        struct Unwind {
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "MVC"
        // Configure collectionview
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        // Start the movie fetch asynchronously and update the datasource
        movieManager.fetchNowPlayingMovies { (result) in
            switch result {
            case let .success(movies):
                self.dataSource.movies = movies
            case let .failure(error):
                print(error)
                self.dataSource.movies.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.Segue.showDetailVC {
            let detailVC = segue.destination as! MovieDetailViewController
            // Grab selected movie instance and pass along manager to DetailVC
            if let selectedIndex = collectionView.indexPathsForSelectedItems?.first?.row {
                let movie = dataSource.movies[selectedIndex]
                detailVC.movie = movie
                detailVC.movieManager = movieManager
            }
        }
    }
}


// MARK: - CollectionView Delegate

extension MovieResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let movie = dataSource.movies[indexPath.item]
        // Download image data for cell asynchronously
        movieManager.fetchImage(forMovie: movie, size: .thumb) { (result) in
            // Make sure it's the same movie object (fetching async)
            guard let movieIndex = self.dataSource.movies.index(of: movie),
                case let .success(image) = result else {
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


// MARK: - UICollectionViewDelegateFlowLayout

extension MovieResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Half screen width with room for 1pt interitemspacing
        let width = (view.bounds.width / 2) - 1
        let height = (view.bounds.height / 2.5) - 1
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
