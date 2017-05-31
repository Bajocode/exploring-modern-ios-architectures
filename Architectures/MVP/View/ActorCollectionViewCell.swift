//
//  ActorCollectionViewCell.swift
//  Architectures
//
//  Created by Fabijan Bajo on 29/05/2017.
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
    
    func configure(with object: Transportable) {
        let presentable = object as! ActorResultsPresenter.PresentableInstance
        thumbImageView.layer.cornerRadius = CGFloat(presentable.cornerRadius)
        nameLabel.text = presentable.name
        thumbImageView.downloadImage(from: presentable.thumbnailURL) {
            if self.thumbImageView.image == nil {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

