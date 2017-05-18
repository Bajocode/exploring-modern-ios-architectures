//
//  MovieCollectionViewCell.swift
//  Architectures
//
//  Created by Fabijan Bajo on 17/05/2017.
//
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateImageView(with: nil)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        updateImageView(with: nil)
    }
    
    
    // MARK: - Methods
    
    func configure(withTitle title: String, rating: String) {
        self.titleLabel.text = title
        self.ratingLabel.text = rating
    }
    
    // Start spinnning when image is being fetched
    func updateImageView(with image: UIImage?) {
        // Update image
        if let imageToDisplay = image {
            activityIndicator.stopAnimating()
            thumbImageView.image = imageToDisplay
        } else {
            activityIndicator.startAnimating()
            thumbImageView.image = nil
        }
    }
}
