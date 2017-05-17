//
//  Movie.swift
//  Architectures
//
//  Created by Fabijan Bajo on 17/05/2017.
//
//

import Foundation


class Movie {
    
    
    // MARK: - Properties
    
    let title: String
    let posterPath: String
    let movieID: Int
    let releaseDate: Date
    let averageRating: Double
    
    
    // MARK: - Initializers
    
    init(title: String, posterPath: String, movieID: Int, releaseDate: Date, averageRating: Double) {
        self.title = title
        self.posterPath = posterPath
        self.movieID = movieID
        self.releaseDate = releaseDate
        self.averageRating = averageRating
    }
}


// MARK: - Equatable

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.movieID == rhs.movieID
    }
}
