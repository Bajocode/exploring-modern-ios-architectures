//
//  MovieManager.swift
//  Architectures
//
//  Created by Fabijan Bajo on 17/05/2017.
//
//
/*
    Task: make network requests and manage the image store of movie posters
*/

import UIKit

final class MovieManager {
    
    
    // MARK: - Properties
    
    private let imageStore = ImageStore()
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }()
    
    
    // MARK: - Methods
    
    // Fetch now playing movies and dispatch on main
    func fetchNowPlayingMovies(completion: @escaping (MoviesResult) -> Void) {
        if TmdbAPI.apiKey == nil {
            // No key provided, use local JSON
            var localData: Data?, localError: Error?
            do {
                localData = try Data(contentsOf: TmdbAPI.nowPlayingLocalURL, options:[])
            } catch { localError = error }
            let result = self.processMoviesRequest(data: localData, error: localError)
            DispatchQueue.main.async {
                completion(result)
            }
        } else {
            // Key provided, fetch new movies
            let request = URLRequest(url: TmdbAPI.nowPlayingMoviesURL)
            let task = session.dataTask(with: request) { (data, response, error) in
                let result = self.processMoviesRequest(data: data, error: error)
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            task.resume()
        }
    }
    private func processMoviesRequest(data: Data?, error: Error?) -> MoviesResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return TmdbAPI.parsedMovies(forJSONData: jsonData)
    }
    
    // Fetch image for movie and dispatch on main
    func fetchImage(forMovie movie: Movie, size: TmdbImageSize, completion: @escaping (ImageResult) -> Void) {
        // Return early if found in local cache or docs dir
        let cacheKey = String(movie.movieID) + size.rawValue
        if let image = imageStore.image(forKey: cacheKey) {
            DispatchQueue.main.async {
                completion(.success(image))
            }
            return
        }
        // Make a new request
        let request = URLRequest(url: TmdbAPI.tmdbImageURL(forSize: size, path: movie.posterPath))
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // Store in cache and dispatch back on main thread
            let result = self.processImageRequest(data: data, error: error)
            if case let .success(image) = result {
                print("Image form network fetch")
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
                    return .failure(MovieError.imageCreationError)
                }
        }
        return .success(image)
    }
}


// MARK: - Movie types

fileprivate enum MovieError: Error {
    case imageCreationError
}

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum MoviesResult {
    case success([Movie])
    case failure(Error)
}
