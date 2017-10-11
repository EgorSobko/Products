//
//  Constants.swift
//  WeaterApp
//
//  Created by Egor Sobko on 04.09.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation

enum Constants {
  
  enum Session {
    
    static var identifier: String = {
      guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
        fatalError("There should be bundle identifier!")
      }
      
      return bundleIdentifier + "session.id"
    }()
  }
  
  enum Weather {
    
    static let key = "a86f12abac5e491bec0e44346b659891"
  }
  
  enum Model {
    
    static let kitModelName = "Kit"
  }
}
