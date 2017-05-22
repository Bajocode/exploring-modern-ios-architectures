//
//  ActorCollectionViewCell.swift
//  Architectures
//
//  Created by Fabijan Bajo on 20/05/2017.
//
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {

    
    // MARK: - Properties
    
    @IBOutlet var nameLabel: UILabel!
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
    
    func configure(with viewModel: ActorViewModel) {
        nameLabel.text = viewModel.actor.name
    }
    func updateImageView(with image: UIImage?, cornerRadius: CGFloat? = nil) {
        thumbImageView.layer.cornerRadius = cornerRadius ?? 0.0
        if let imageToDisplay = image {
            activityIndicator.stopAnimating()
            thumbImageView.image = imageToDisplay
        } else {
            activityIndicator.startAnimating()
            thumbImageView.image = nil
        }
    }
}
