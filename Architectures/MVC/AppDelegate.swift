//
//  AppDelegate.swift
//  MVC
//
//  Created by Fabijan Bajo on 17/05/2017.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Instantiate ResultVC's
        let movieResultsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultsVC") as! ResultsViewController
        movieResultsVC.modelType = .movie
        movieResultsVC.title = "Movies"
        let actorResultsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultsVC") as! ResultsViewController
        actorResultsVC.modelType = .actor
        actorResultsVC.title = "Actors"
        
        // Allocate navigation and tabbar controllers
        let navC = window?.rootViewController as! UINavigationController
        let tabC = navC.topViewController as! UITabBarController
        tabC.setViewControllers([movieResultsVC, actorResultsVC], animated: false)
        
        return true
    }
}

