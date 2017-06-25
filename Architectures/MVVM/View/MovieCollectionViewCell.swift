//
//  MovieCollectionViewCell.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell, CellConfigurable {

    
    // MARK: - Properties
    
    @IBOutlet fileprivate var titleLabel: UILabel!
    @IBOutlet fileprivate var ratingLabel: UILabel!
    @IBOutlet fileprivate var thumbImageView: UIImageView!
    @IBOutlet fileprivate var activityIndicator: UIActivityIndicatorView!
    
    
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
        let instance = object as! MovieViewModel.PresentableInstance
        titleLabel.text = instance.title
        ratingLabel.text = instance.ratingText
        thumbImageView.downloadImage(from: instance.thumbnailURL) { 
            if self.thumbImageView.image == nil {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
