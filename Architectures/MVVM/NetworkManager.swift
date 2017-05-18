//
//  NetworkManager.swift
//  Architectures
//
//  Created by Fabijan Bajo on 16/05/2017.
//
//

import Foundation

protocol NetworkManagerDelegate: class {
    func dataReceived(result: MoviesResult)
}

final class NetworkManager {
    
    
    // MARK: - Properties
    
    var delegate: NetworkManagerDelegate?
    
    // MARK: - Methods
        
    // Fetch now playing movies and dispatch on main
    func fetchNowPlayingMovies() {
        let request = URLRequest(url: TmdbAPI.nowPlayingMoviesURL)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let result = self.processMoviesRequest(data: data, error: error)
            DispatchQueue.main.async {
                self.delegate?.dataReceived(result: result)
            }
        }
        task.resume()
    }
    private func processMoviesRequest(data: Data?, error: Error?) -> MoviesResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return TmdbAPI.parsedMovies(forJSONData: jsonData)
    }
}


// MARK: - Movie request type

enum MoviesResult {
    case success([MovieViewModel])
    case failure(Error)
}
