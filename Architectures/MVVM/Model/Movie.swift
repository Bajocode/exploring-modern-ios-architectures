//
//  Movie.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//

import Foundation

struct Movie: Transportable {
    
    // MARK: - Properties
    
    let title: String
    let posterPath: String
    let movieID: Int
    let releaseDate: String
    let averageRating: Double
}


// MARK: - Equatable

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.movieID == rhs.movieID
    }
}
