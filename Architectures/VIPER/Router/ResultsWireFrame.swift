//
//  ResultsViewWireFrame.swift
//  Architectures
//
//  Created by Fabijan Bajo on 31/05/2017.
//
//

import UIKit

class ResultsWireFrame: ResultsWireFrameInterface {
    
    // Wire up and construct project's root view (UITabbarController)
    class func constructResultsModule() -> UIViewController {
        // Allocate resultVC's
        let movieResultsVC = ResultsViewController()
        let moviePresenter = ResultsPresenter()
        let movieInteractor = MovieResultsInteractor()
        moviePresenter.interactor = movieInteractor
        moviePresenter.view = movieResultsVC
        moviePresenter.wireFrame = ResultsWireFrame()
        movieInteractor.output = moviePresenter
        movieResultsVC.presenter = moviePresenter
        movieResultsVC.title = "Movies"
        
        // Configure containers
        let tabBarC = UITabBarController()
        let navC = UINavigationController(rootViewController: tabBarC)
        tabBarC.setViewControllers([movieResultsVC], animated: false)
        navC.navigationBar.barStyle = .black
        tabBarC.tabBar.barStyle = .black
        
        return tabBarC
    }
    
    // Show detailview from presenter
    func showDetail(from view: ResultsViewInterface, forPresentable object: Transportable) {
        let detailVC = DetailViewController()
        detailVC.presentableObject = object
    }
}
