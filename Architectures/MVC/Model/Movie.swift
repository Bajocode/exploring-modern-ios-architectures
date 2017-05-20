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

struct Movie {
    
    
    // MARK: - Properties
    
    let title: String
    let posterPath: String
    let movieID: Int
    let releaseDate: Date
    let averageRating: Double
}


// MARK: - Equatable

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.movieID == rhs.movieID
    }
}
