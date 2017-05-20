//
//  MovieCollectionViewCell.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
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
    
    func configure(with viewModel: MovieViewModel) {
        titleLabel.text = viewModel.movie.title
        ratingLabel.text = viewModel.rating
    }
    func updateImageView(with image: UIImage?, cornerRadius: CGFloat? = nil) {
        thumbImageView.layer.cornerRadius = cornerRadius ?? 0.0
        // Update Image
        if let imageToDisplay = image {
            activityIndicator.stopAnimating()
            thumbImageView.image = imageToDisplay
        } else {
            activityIndicator.startAnimating()
            thumbImageView.image = nil
        }
    }
}
