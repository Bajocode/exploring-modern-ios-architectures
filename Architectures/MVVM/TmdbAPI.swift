//
//  TmdbAPI.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import Foundation

struct TmdbAPI {
    
    
    // MARK: - Properties
    
    private static let baseURLString = "https://api.themoviedb.org/3"
    private static let baseImageURLString = "https://image.tmdb.org/t/p"
    static var apiKey: String? { // Return key if provided in plist
        guard
            let path = Bundle.main.path(forResource: "tmdbAPIKey", ofType: "plist"),
            let plistDict = NSDictionary(contentsOfFile: path),
            let apiKey = plistDict["apiKey"] as? String,
            apiKey != "API KEY HERE" && apiKey != "" else {
                return nil
        }
        return apiKey
    }
    private static let tmdbDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }()
    
    
    
    // MARK: - Methods
    
    // Generate Tmdb specific image URLs
    static func tmdbImageURL(forSize size: TmdbImageSize, path: String) -> URL {
        return URL(string: baseImageURLString + "/" + size.rawValue + "/" + path)!
    }

    static func remoteURL(withType type: ObjectType) -> URL {
        switch type {
        case .movie:
            return constructTmdbURL(forMethod: .nowPlayingMovies)
        case .actor:
            return constructTmdbURL(forMethod: .popularActors)
        }
    }
    
    static func localURL(withType type: ObjectType) -> URL {
        switch type {
        case .movie:
            return localJSONURL(forFileName: "moviedata")
        case .actor:
            return localJSONURL(forFileName: "actordata")
        }
    }
    
    // Constructs URL's specific to the Tmdb server API
    private static func constructTmdbURL(forMethod method: TmdbMethod, extraParameters: [String:String]? = nil) -> URL {
        let urlWithMethod = baseURLString + method.rawValue
        var components = URLComponents(string: urlWithMethod)!
        var queryItems = [URLQueryItem]()
        
        // Base param required for all Tmdb requests
        queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
        
        // Optional extra params for specific requests
        if let extraParams = extraParameters {
            for (key,value) in extraParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        return components.url!
    }
    
    private static func localJSONURL(forFileName fileName: String) -> URL {
        return Bundle.main.url(forResource: fileName, withExtension: "json")!
    }
}


// MARK: - Tmdb related help types

enum TmdbImageSize: String {
    case full = "original"
    case thumb = "w300"
}

fileprivate enum TmdbMethod: String {
    case nowPlayingMovies = "/movie/now_playing"
    case popularActors = "/person/popular"
}

