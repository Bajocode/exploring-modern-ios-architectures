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
        
        // Fetch movies
        DataManager.shared.fetchNowPlayingMovies { (result) in
            switch result {
            case let .success(movieViewModels):
                movieResultsVC.data = movieViewModels
            case let .failure(error):
                print(error)
            }
        }
        
        // Set the tabbar items
        setViewControllers([movieResultsVC], animated: false)
    }
    
    
    // MARK: - Methods
    
    
    
    // MARK: - Actions
    
    
    
    // MARK: - Navigation
}


