//
//  DetailViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import UIKit

class DetailViewController: UIViewController {

    
    // MARK: - Properties
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var viewModel: DetailRepresentable!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
    // MARK: - Methods
    
    private func setUp() {
        // Set navigation title
        var title = ""
        if let movieVM = viewModel as? MovieViewModel {
            title = movieVM.movie.title
        } else if let actorVM = viewModel as? ActorViewModel {
            title = actorVM.actor.name
        }
        navigationItem.title = title
        
        // Network calls go through VM
        activityIndicator.startAnimating()
        viewModel.updateFullImage { (image) in
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }

}
