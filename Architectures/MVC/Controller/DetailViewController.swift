//
//  DetailViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 30/05/2017.
//
//

import UIKit

class DetailViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var modelObject: Transportable!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    // MARK: - Methods
    
    func configure() {
        // Determine url
        activityIndicator.startAnimating()
        var url: URL!
        switch modelObject {
        case let movie as Movie:
            navigationItem.title = movie.title
            url = movie.fullURL
        case let actor as Actor:
            navigationItem.title = actor.name
            url = actor.fullURL
        default: break
        }
        // Fetch image
        imageView.downloadImage(from: url) {
            self.activityIndicator.stopAnimating()
        }
    }
}


