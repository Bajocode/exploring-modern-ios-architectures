//
//  DataManager.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//
/*
    SINGLETON: The only accesspoint to everything data model (processing and networking) related
*/

import UIKit

final class DataManager {
    
    
    // MARK: - Properties
    
    static let shared = DataManager()
    let imageStore = ImageStore()
    
    
    // MARK: - Initializers
    
    private init() {}
    
    
    // MARK: - Methods
    
    // Fetch now playing movies and dispatch on main
    public func fetchNewTmdbObjects(withType type: ModelType, completion: @escaping (DataResult) -> Void) {
        if TmdbAPI.apiKey == nil {
            // No key provided, use local JSON
            var localData: Data?, localError: Error?
            do {
                localData = try Data(contentsOf: TmdbAPI.localURL(withType: type), options:[])
            } catch { localError = error }
            let result = self.processRequest(data: localData, error: localError, type: type)
            DispatchQueue.main.async {
                completion(result)
            }
        } else {
            // Key provided, fetch new movies
            let request = URLRequest(url: TmdbAPI.remoteURL(withType: type))
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let result = self.processRequest(data: data, error: error, type: type)
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            task.resume()
        }
    }
    private func processRequest(data: Data?, error: Error?, type: ModelType) -> DataResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return TmdbParser.parsedResult(withJSONData: jsonData, type: type)
    }
}


// MARK: - Data related helper types

enum ModelType {
    case movie
    case actor
}
enum DataResult {
    case success([Transportable])
    case failure(Error)
}
