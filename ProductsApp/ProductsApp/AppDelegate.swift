//
//  AppDelegate.swift
//  ProductsApp
//
//  Created by Egor Sobko on 10.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import UIKit
import Kit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var mainRouter: MainRouter?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow()
    let networkService = UserSessionControllerNetworkService()
    let userSessionController = UserSessionController(userDefaults: UserDefaults.standard, networkService: networkService)
    let mainRouter = MainRouter(userSessionController: userSessionController)
    mainRouter.execute(in: window!)
    self.mainRouter = mainRouter
    
    return true
  }

}

