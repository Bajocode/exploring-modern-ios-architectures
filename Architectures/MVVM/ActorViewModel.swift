//
//  ActorViewModel.swift
//  Architectures
//
//  Created by Fabijan Bajo on 20/05/2017.
//
//

import UIKit

struct ActorViewModel {
    
    
    // MARK: - Properties
    
    var actor: Actor!
    
    
    // MARK: - Initializers
    
    init(actor: Actor) {
        self.actor = actor
    }
    
}

extension ActorViewModel: CellRepresentable {
    
    // Properties
    var objectID: Int {
        return actor.actorID
    }
    var thumbImageURL: URL {
        return TmdbAPI.tmdbImageURL(forSize: .thumb, path: actor.profilePath)
    }
    var cellID: String {
        return "ActorCell"
    }
    var cornerRadius: CGFloat? {
        return 5.0
    }
    
    // Methods
    func cellSize(withBounds bounds: CGRect) -> CGSize {
        let width = (bounds.width - 1) / 3
        let height = (bounds.height - 1) / 2
        return CGSize(width: width, height: height)
    }
    func cellInstance(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        // Instantiate
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ActorCollectionViewCell
        // Setup cell with self and return
        cell.configure(with: self)
        return cell
    }
    func updateCellImage(_ collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        DataManager.shared.imageManager.fetchImage(with: thumbImageURL) { (result) in
            // Make sure it's the same movie object (fetching async)
            guard
                case let .success(image) = result,
                let actorCell = collectionView.cellForItem(at: indexPath) as? ActorCollectionViewCell else {
                    return
            }
            // Update cell when image request finishes, if cell still visible on screen
            actorCell.updateImageView(with: image, cornerRadius: self.cornerRadius)
        }
    }
}
