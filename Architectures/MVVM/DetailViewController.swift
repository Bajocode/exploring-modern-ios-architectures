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
        title = (viewModel as! MovieViewModel).movie.title
        
        // Network calls go through VM
        activityIndicator.startAnimating()
        viewModel.updateFullImage { (image) in
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }

}
