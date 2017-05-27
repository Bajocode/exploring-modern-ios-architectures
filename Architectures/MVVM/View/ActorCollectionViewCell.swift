//
//  ActorCollectionViewCell.swift
//  Architectures
//
//  Created by Fabijan Bajo on 27/05/2017.
//
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell, CellConfigurable {
    
    
    // MARK: - Properties
    
    @IBOutlet fileprivate var nameLabel: UILabel!
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
    
    func configure(with converted: Parsable) {
        let instance = converted as! ActorViewModel.PresentableInstance
        nameLabel.text = instance.name
        thumbImageView.downloadImage(from: instance.thumbnailURL) {
            if self.thumbImageView.image == nil {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
