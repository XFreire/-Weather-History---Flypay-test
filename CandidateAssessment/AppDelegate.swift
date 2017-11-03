//
//  AppDelegate.swift
//  CandidateAssessment
//
//  Created by Daniel Iglesias on 19/06/2017.
//  Copyright © 2017 Flypay. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appAssembly = AppAssembly()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let initialViewController = appAssembly.coreAssembly.listAssembly.viewController()
        appAssembly.navigationController.pushViewController(initialViewController, animated: false)
        appAssembly.window.rootViewController = appAssembly.navigationController
        appAssembly.window.makeKeyAndVisible()
        
        return true
    }

}

