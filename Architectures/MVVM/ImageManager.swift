//
//  ImageManager.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import UIKit

class ImageManager {
    
    
    // MARK: - Properties
    
    private let imageStore = ImageStore()
    
    
    // MARK: - Methods
    
    // Fetch image for movie and dispatch on main
    func fetchImage(forVM vm: CellRepresentable, size: TmdbImageSize, completion: @escaping (ImageResult) -> Void) {
        // Return early if found in local cache or docs dir
        let cacheKey = String(vm.objectID) + size.rawValue
        if let image = imageStore.image(forKey: cacheKey) {
            DispatchQueue.main.async {
                completion(.success(image))
            }
            return
        }
        // Make a new request
        let request = URLRequest(url: vm.imageURL)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("Called Fetch")
            // Store in cache and dispatch back on main thread
            let result = self.processImageRequest(data: data, error: error)
            if case let .success(image) = result {
                self.imageStore.setImage(image, forKey: cacheKey)
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }
        task.resume()
    }
    private func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                // Couldn't create image
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(ImageError.imageCreationError)
                }
        }
        return .success(image)
    }
}

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum ImageError: Error {
    case imageCreationError
}

    
