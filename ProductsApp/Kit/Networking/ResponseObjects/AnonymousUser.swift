//
//  AnonymousUser.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import ObjectMapper

public class AnonymousUser: Mappable {
  
  private(set) var locale: String?
  private(set) var userToken: String?
  private(set) var storeId: Int = 0
  
  public required convenience init?(map: Map) {
    self.init()
  }
  
  public func mapping(map: Map) {
    self.locale <- map["locale"]
    self.userToken <- map["user_token"]
    self.storeId <- map["store_id"]
  }
}
