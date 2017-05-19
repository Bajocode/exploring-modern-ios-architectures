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
    
    
    // MARK: - Methods
    
    func configure(with viewModel: MovieViewModel) {
        titleLabel.text = viewModel.movie.title
        ratingLabel.text = viewModel.rating
    }
}
