//
//  MovieDetailViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import UIKit

class MovieDetailViewController: UIViewController {

    
    // MARK: - Properties
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var movie: Movie! {
        didSet {
            navigationItem.title = movie.title
        }
    }
    var movieManager: MovieManager!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    // MARK: - Methods
    
    func setup() {
        activityIndicator.startAnimating()
        movieManager.fetchImage(forMovie: movie, size: .full) { (result) in
            switch result {
            case let .success(image):
                self.activityIndicator.stopAnimating()
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for movie: \(error)")
            }
        }
    }
}

