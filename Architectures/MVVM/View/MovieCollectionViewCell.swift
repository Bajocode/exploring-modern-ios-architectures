//
//  MovieCollectionViewCell.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    
    // MARK: - Properties
    
    @IBOutlet fileprivate var titleLabel: UILabel!
    @IBOutlet fileprivate var ratingLabel: UILabel!
    @IBOutlet fileprivate var thumbImageView: UIImageView!
    @IBOutlet fileprivate var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.startAnimating()
    }
    override func prepareForReuse() {
        activityIndicator.startAnimating()
    }
}


// MARK: - ImageCellConfigurable

extension MovieCollectionViewCell: CellConfigurable {
    
    // MARK: - Methods
    
    func configure(with converted: Convertable) {
        activityIndicator.startAnimating()
        let uiReadyMovie = converted as! MovieViewModel.UIReadyInstance
        titleLabel.text = uiReadyMovie.title
        ratingLabel.text = uiReadyMovie.ratingText
        activityIndicator.startAnimating()
        thumbImageView.downloadImage(with: uiReadyMovie.thumbnailURL) { 
            self.activityIndicator.stopAnimating()
        }
    }
}
