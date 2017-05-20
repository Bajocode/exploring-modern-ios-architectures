//
//  DataManager.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//
/*
    The only accesspoint to everything data and network related
*/

import UIKit

final class DataManager {
    
    
    // MARK: - Properties
    
    static let shared = DataManager()
    let imageManager = ImageManager()
    
    
    // MARK: - Initializers
    
    private init() {}
    
    
    // MARK: - Methods
    
    // Fetch now playing movies and dispatch on main
    func fetchNewTmdbObjects(withType type: ObjectType, completion: @escaping (DataResult) -> Void) {
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
    private func processRequest(data: Data?, error: Error?, type: ObjectType) -> DataResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return TmdbParser.parsedResult(withJSONData: jsonData, type: type)
    }
}


// MARK: - Data related helper types

enum ObjectType {
    case movie
    case actor
}
enum DataResult {
    case success([Parsable])
    case failure(Error)
}
