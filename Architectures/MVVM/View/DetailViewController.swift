//
//  DetailViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 26/05/2017.
//
//

import UIKit

class DetailViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var imageURL: URL!
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
        view.addSubview(imageView)
        imageView.downloadImage(from: imageURL)
    }
}
