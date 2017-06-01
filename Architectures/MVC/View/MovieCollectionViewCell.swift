//
//  MovieCollectionViewCell.swift
//  Architectures
//
//  Created by Fabijan Bajo on 30/05/2017.
//
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell, CellConfigurable {
    
    
    // MARK: - Properties
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.startAnimating()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        activityIndicator.startAnimating()
    }
    
    
    // MARK: - Methods
    
    func configure(with object: Transportable) {
        let movie = object as! Movie
        titleLabel.text = movie.title
        ratingLabel.text = movie.averageRating
        thumbImageView.downloadImage(from: movie.thumbnailURL) {
            if self.thumbImageView.image == nil {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
