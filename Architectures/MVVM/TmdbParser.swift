//
//  TmdbParser.swift
//  Architectures
//
//  Created by Fabijan Bajo on 20/05/2017.
//
//

import Foundation

struct TmdbParser {
    
    // Call inidvidual movie parser and pass MoviesResult to MovieManager
    static func parsedResult(withJSONData data: Data, type: ObjectType) -> DataResult {
        do{
            // Serialize raw json into foundation json and retrieve movie array
            let jsonFoundationObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
                let jsonDict = jsonFoundationObject as? [AnyHashable:Any],
                let jsonObjectsArray = jsonDict["results"] as? [[String:Any]] else {
                    return .failure(TmdbError.invalidJSONData(key: "results", dictionary: jsonFoundationObject))
            }
            return .success(parsedObjects(withJSONArray: jsonObjectsArray, type: type))
        } catch let serializationError {
            return .failure(serializationError)
        }
    }
    
    private static func parsedObjects(withJSONArray array: [[String: Any]], type: ObjectType) -> [Parsable] {
        // Parse individual movies
        var parsedObjects = [Parsable]()
        for jsonObject in array {
            switch type {
            case .movie:
                if let movie = parsedMovie(forMovieJSON: jsonObject) {
                    parsedObjects.append(movie)
                }
            case .actor:
                if let actor = parsedActor(forActorJSON: jsonObject) {
                    parsedObjects.append(actor)
                }
            }
        }
        // If not able to parse movies, perhaps because JSON format changed
        if !array.isEmpty && parsedObjects.isEmpty {
            print("!jsonObjectsArray.isEmpty && parsedMovies.isEmpty")
        }
        return parsedObjects
    }
    
    // Parse individual movie dictionaries, extracted from json response
    private static func parsedMovie(forMovieJSON json: [String:Any]) -> Parsable? {
        guard
            let movieID = json["id"] as? Int,
            let title = json["title"] as? String,
            let posterPath = json["poster_path"] as? String,
            let averageRating = json["vote_average"] as? Double,
            let releaseDate = json["release_date"] as? String else {
                // Do not have enough information to construct the object
                return nil
        }
        return Movie(title: title, posterPath: posterPath, movieID: movieID, releaseDate: releaseDate, averageRating: averageRating) as? Parsable
    }
    
    // Parse individual actor dictionaries, extracted from json response
    private static func parsedActor(forActorJSON json: [String:Any]) -> Parsable? {
        guard
            let actorID = json["id"] as? Int,
            let name = json["name"] as? String,
            let profilePath = json["profile_path"] as? String else {
                // Do not have enough information to construct the object
                return nil
        }
        return Actor(name: name, profilePath: profilePath, actorID: actorID) as? Parsable
    }
    
}

fileprivate enum TmdbError: CustomStringConvertible, Error {
    case invalidJSONData(key: String, dictionary: Any)
    case serializationError(error: Error)
    case other(string: String)
    var description: String {
        switch self {
        case .invalidJSONData(let key, let dict):
            return "Could not find key '\(key)' in JSON dictionary:\n \(dict)"
        case .serializationError(let error):
            return "JSON serialization failed with error:\n \(error)"
        case .other(let string):
            return string
        }
    }
}
