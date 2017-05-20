//
//  TabBarViewController.swift
//  Architectures
//
//  Created by Fabijan Bajo on 19/05/2017.
//
//

import UIKit

class TabBarViewController: UITabBarController {

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieResultsVC = ResultsViewController()
        movieResultsVC.title = "MVVM"
        
        // Fetch movies
        DataManager.shared.fetchNewTmdbObjects(withType: .movie) { (result) in
            switch result {
            case let .success(movies):
                movieResultsVC.data = movies.map { MovieViewModel(movie: $0 as! Movie) }
            case let .failure(error):
                print(error)
            }
        }
        
        // Set the tabbar items
        setViewControllers([movieResultsVC], animated: false)
    }
}


