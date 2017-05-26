//
//  Extensions.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//

import UIKit

// Offload layout implementation from View to layout itself
extension UICollectionViewFlowLayout {
    convenience init(viewModel: CollectionViewConfigurable, bounds: CGRect) {
        self.init()
        // Calculate and set itemSize
        let spacing = CGFloat(viewModel.interItemSpacing ?? 0)
        let width = (bounds.width - spacing) / CGFloat(viewModel.widthDivisor)
        let height = (bounds.height - spacing) / CGFloat(viewModel.heightDivisor)
        let size = CGSize(width: width, height: height)
        itemSize = size
        
        // Configure spacing
        sectionInset = UIEdgeInsets(
            top: CGFloat(viewModel.topInset ?? 0),
            left: CGFloat(viewModel.horizontalInsets ?? 0),
            bottom: CGFloat(viewModel.bottomInset ?? 0),
            right: CGFloat(viewModel.horizontalInsets ?? 0)
        )
        minimumInteritemSpacing = CGFloat(viewModel.interItemSpacing ?? 0)
        minimumLineSpacing = CGFloat(viewModel.lineSpacing ?? 0)
    }
}

// Enable easy image downloads 
extension UIImageView {
    // Testing this solution
    func downloadImage(with url: URL) {
        // Remove "/" because docs dir sees as folders
        let cacheKey = url.path.components(separatedBy: "/").dropFirst(3).joined(separator: "")
        // Return early if found in local cache or docs dir
        if let image = DataManager.shared.imageStore.image(forKey: cacheKey) {
            DispatchQueue.main.async { self.image = image }
            return
        }
        // Not in cache or docs? Make a new request
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let imageData = data,
                error == nil,
                let newImage = UIImage(data: imageData) else {
                    print("Fetching image failed for path: \(url.path)")
                    return
            }
            // Put the image in cache and dispatch on main
            DataManager.shared.imageStore.setImage(newImage, forKey: cacheKey)
            DispatchQueue.main.async { self?.image = newImage }
        }.resume()
    }
}


