//
//  DataManager.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import UIKit

final class DataManager {
    
    
    // MARK: - Properties
    
    static let shared = DataManager()
    let imageManager = ImageManager()
    
    
    // MARK: - Initializers
    
    private init() {}
    
    
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
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
    
}



enum MoviesResult {
    case success([MovieViewModel])
    case failure(Error)
}
