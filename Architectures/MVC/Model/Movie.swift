//
//  Movie.swift
//  Architectures
//
//  Created by Fabijan Bajo on 17/05/2017.
//
//
/*
    Task: represent a single Movie
*/

import Foundation

struct Movie: Parsable {
    
    
    // MARK: - Properties
    
    let title: String
    let thumbnailURL: URL
    let fullURL: URL
    let movieID: Int
    let releaseDate: String
    let averageRating: String
}


// MARK: - Equatable

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.movieID == rhs.movieID
    }
}
