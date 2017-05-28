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


// MARK: - UIImageView

extension UIImageView {
    func downloadImage(from url: URL, completion: (() -> Void)? = nil) {
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
