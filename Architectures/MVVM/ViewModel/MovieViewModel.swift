//
//  MovieViewModel.swift
//  Architectures
//
//  Created by Fabijan Bajo on 25/05/2017.
//
//
/*
    MVVM ViewModels should not access UIKit
*/

import Foundation

class MovieViewModel: ViewModel {
    
    
    // MARK: - Properties
    
    private var movies = [Movie]() {
        didSet {
            didChange?()
        }
    }
    private var didChange: (() -> Void)?
    subscript (index: Int) -> URL? {
        return URL(string: movies[index].posterPath)
    }
    var count: Int {
        return movies.count
    }
    
    
    // MARK: - Methods
    
    func bind(didChange: @escaping () -> Void) {
        self.didChange = didChange
    }
    
    func fetchNewModelObjects() {
        DataManager.shared.fetchNewTmdbObjects(withType: .movie) { (result) in
            switch result {
            case let .success(parsables):
                self.movies = parsables as! [Movie]
            case let .failure(error):
                print(error)
            }
        }
    }
}


// MARK: - CellRepresentable

extension MovieViewModel: CellRepresentable {
    
    // MARK: - Properties
    
    // Required
    var cellID: String { return "MovieCell" }
    var widthDivisor: Double { return 2.0 }
    var heightDivisor: Double { return 2.5 }
    
    // Optional
    var interItemSpacing: Int? { return 1 }
    var lineSpacing: Int? { return 1 }
}

