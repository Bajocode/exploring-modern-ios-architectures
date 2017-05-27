//
//  MovieCollectionViewCell.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell, CellConfigurable {

    
    // MARK: - Properties
    
    @IBOutlet fileprivate var titleLabel: UILabel!
    @IBOutlet fileprivate var ratingLabel: UILabel!
    @IBOutlet fileprivate var thumbImageView: UIImageView!
    @IBOutlet fileprivate var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Methods
    
    func configure(with converted: Parsable) {
        let instance = converted as! MovieViewModel.PresentableInstance
        titleLabel.text = instance.title
        ratingLabel.text = instance.ratingText
        thumbImageView.downloadImage(from: instance.thumbnailURL)
    }
}
