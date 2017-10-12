//
//  Constants.swift
//  WeaterApp
//
//  Created by Egor Sobko on 04.09.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation

enum Constants {
  
  enum APIEndpoints {
    
    static let baseURL = "app-testing.lesara.de/restapi/"
    static let anonuser = "anonuser"
    static let apiContext = "api"
    static let trendproducts = "trendproducts"
  }

  enum Session {
    
    static var identifier: String = {
      guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
        fatalError("There should be bundle identifier!")
      }
      
      return bundleIdentifier + "session.id"
    }()
  }
  
  enum API {
    
    static let token = "this_is_an_app_token"
  }
}
