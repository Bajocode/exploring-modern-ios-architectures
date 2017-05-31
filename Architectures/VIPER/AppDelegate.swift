//
//  AppDelegate.swift
//  VIPER
//
//  Created by Fabijan Bajo on 30/05/2017.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Set window's root and make visible
        window!.rootViewController = ResultsWireFrame.constructStartingPoint()
        window!.makeKeyAndVisible()
        
        return true
    }
}

