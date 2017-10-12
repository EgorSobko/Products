//
//  Credentials.swift
//  ProductsApp
//
//  Created by Egor Sobko on 11.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation

public struct Credentials {
  
  // MARK: - Properties
  let id: String
  let userToken: String
  let storeId: Int
  var representation: [String: Any] {
    return ["id": id, "userToken": userToken, "storeId": storeId]
  }
  
  // MARK: - Init
  init(id: String, userToken: String, storeId: Int) {
    self.id = id
    self.userToken = userToken
    self.storeId = storeId
  }
  
  init?(representation: [String: Any]) {
    guard
      let id = representation["id"] as? String,
      let userToken = representation["userToken"] as? String,
      let storeId = representation["storeId"] as? Int else { return nil }
    
    self.id = id
    self.userToken = userToken
    self.storeId = storeId
  }
}
