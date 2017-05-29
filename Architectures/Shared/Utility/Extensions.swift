//
//  Extensions.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//

import UIKit


// MARK: - UICollectionViewFlowLayout

extension UICollectionViewFlowLayout {
    // Inits layout with equal spacing for all insets and itemspacings
    convenience init(allSpacingEqualFor viewModel: CollectionViewConfigurable, bounds: CGRect) {
        self.init()
        // Define values
        let spacing = CGFloat(viewModel.interItemSpacing ?? 0)
        let tabBarInset = CGFloat(viewModel.bottomInset ?? 0)
        let widthDivisor = CGFloat(viewModel.widthDivisor)
        let heightDivisor = CGFloat(viewModel.heightDivisor)
        
        // Itemsize (if all spacing / insets are equal)
        let fullWspace = (widthDivisor + 1) * spacing
        let fullHspace = (heightDivisor + 1) + spacing
        let width = (bounds.width - fullWspace) / widthDivisor
        let height = (bounds.height - fullHspace) / heightDivisor
        self.itemSize = CGSize(width: width, height: height)
        
        // Configure insets
        sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: tabBarInset,
            right: spacing
        )
        minimumInteritemSpacing = spacing
        minimumLineSpacing = spacing
    }
}


// MARK: - UIImageView

extension UIImageView {
    public func downloadImage(from url: URL, completion: (() -> Void)? = nil) {
        // Remove "/" because docs dir sees as folders
        let cacheKey = url.path.components(separatedBy: "/").dropFirst(3).joined(separator: "") 
        // Return early if found in local cache or docs dir
        if let image = DataManager.shared.imageStore.image(forKey: cacheKey) {
            DispatchQueue.main.async {
                self.image = image
                completion?()
            }
            return
        }
        // Nothing in cache / docs? Fetch new
        // ImageView could be nil, use [weak self] capture list
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            print("Image from network fetch")
            guard let httpURLResponse = response as? HTTPURLResponse,  httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data) else {
                    completion?()
                    print("Could not fetch image for url: \(url.path)")
                    return
            }
            DataManager.shared.imageStore.setImage(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self?.image = image
                completion?()
            }
        }).resume()
    }
}
