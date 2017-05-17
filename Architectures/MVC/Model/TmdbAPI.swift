//
//  TmdbAPI.swift
//  Architectures
//
//  Created by Fabijan Bajo on 17/05/2017.
//
//

import Foundation


struct TmdbAPI {
    
    
    // MARK: - Properties
    
    private static let baseURLString = "https://api.themoviedb.org/3"
    private static let baseImageURLString = "https://image.tmdb.org/t/p"
    private static let apiKey = "91e3a1fc957cde9192fede75cedb96e2"
    private static let tmdbDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }()
    static var nowPlayingMoviesURL: URL {
        return constructTmdbURL(forMethod: .nowPlayingMovies)
    }
    static var popularActorsURL: URL {
        return constructTmdbURL(forMethod: .popularActors)
    }
    
    
    // MARK: - Methods
    
    // Generate Tmdb specific image URLs
    static func tmdbImageURL(forSize size: TmdbImageSize, path: String) -> URL {
        return URL(string: baseImageURLString + "/" + size.rawValue + "/" + path)!
    }
    
    // Call inidvidual movie parser and pass MoviesResult to MovieManager
    static func parsedMovies(forJSONData data: Data) -> MoviesResult {
        do{
            // Serialize raw json into foundation json and retrieve movie array
            let jsonFoundationObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
                let jsonDict = jsonFoundationObject as? [AnyHashable:Any],
                let jsonObjectsArray = jsonDict["results"] as? [[String:Any]] else {
                    return .failure(TmdbError.invalidJSONData)
            }
            // Parse individual movies
            var parsedMovies = [Movie]()
            for jsonObject in jsonObjectsArray {
                if let movie = parsedMovie(forMovieJSON: jsonObject) {
                    parsedMovies.append(movie)
                }
            }
            // If not able to parse movies, perhaps because JSON format changed
            if !jsonObjectsArray.isEmpty && parsedMovies.isEmpty {
                return .failure(TmdbError.invalidJSONData)
            }
            return .success(parsedMovies)
        } catch let serializationError {
            return .failure(serializationError)
        }
    }
    
    // Parse individual movie dictionaries, extracted from json response
    private static func parsedMovie(forMovieJSON json: [String:Any]) -> Movie? {
        guard
            let movieID = json["id"] as? Int,
            let title = json["title"] as? String,
            let posterPath = json["poster_path"] as? String,
            let averageRating = json["vote_average"] as? Double,
            let releaseDateString = json["release_date"] as? String,
            let releaseDate = tmdbDateFormatter.date(from: releaseDateString) else {
                // Do not have enough information to construct the object
                return nil
        }
        return Movie(title: title, posterPath: posterPath, movieID: movieID, releaseDate: releaseDate, averageRating: averageRating)
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
}


// MARK: - Tmdb related types

enum TmdbImageSize: String {
    case full = "original"
    case thumb = "w300"
}

fileprivate enum TmdbError: Error {
    case invalidJSONData
}

fileprivate enum TmdbMethod: String {
    case nowPlayingMovies = "/movie/now_playing"
    case popularActors = "/person/popular"
}
