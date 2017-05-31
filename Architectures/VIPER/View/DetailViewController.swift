//
//  DetailViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 31/05/2017.
//
//

import UIKit

class DetailViewController: UIViewController {

    
    // MARK: - Properties
    
    var presentableObject: Transportable!
    
    // Use lazy to access self.view when instantiated
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        return indicator
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    // MARK: - Methods
    
    private func configure() {
        // View setup
        view.backgroundColor = .black
        view.addSubview(imageView)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        // Image fetching
        var imageURL: URL!
        switch presentableObject {
        case let moviePresentable as MovieResultsInteractor.PresentableInstance:
            tabBarController?.navigationItem.title = moviePresentable.title
            imageURL = moviePresentable.fullSizeURL
        case let actorPresentable as ActorResultsInteractor.PresentableInstance:
            tabBarController?.navigationItem.title = actorPresentable.name
            imageURL = actorPresentable.fullSizeURL
        default: break
        }
        imageView.downloadImage(from: imageURL) {
            self.activityIndicator.stopAnimating()
        }
    }
}
