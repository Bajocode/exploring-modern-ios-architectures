//
//  ImageManager.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//
/*
    Access point for everything related to image data, only accessible through DataManager
*/

import UIKit

class ImageManager {
    
    
    // MARK: - Properties
    
    private let imageStore = ImageStore()
    
    
    // MARK: - Methods
    
    // Fetch image for movie and dispatch on main
    func fetchImage(with url: URL, completion: @escaping (ImageResult) -> Void) {
        // Remove "/" because docs dir sees as folders
        let cacheKey = url.path.components(separatedBy: "/").dropFirst(3).joined(separator: "")
        // Return early if found in local cache or docs dir
        if let image = imageStore.image(forKey: cacheKey) {
            DispatchQueue.main.async { completion(.success(image)) }
            return
        }
        // Make a new request
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("Called Fetch")
            // Store in cache and dispatch back on main thread
            let result = self.processImageRequest(data: data, error: error)
            if case let .success(image) = result {
                self.imageStore.setImage(image, forKey: cacheKey)
            }
            DispatchQueue.main.async { completion(result) }
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

    
