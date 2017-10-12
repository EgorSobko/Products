//
//  ProductResponse.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import ObjectMapper

public class ProductResponse: Mappable {
  
  public private(set) var products: [Product] = []
  public private(set) var pagesCount = 1
  public private(set) var page = 1
  
  public required convenience init?(map: Map) {
    self.init()
  }
  
  public func mapping(map: Map) {
    self.products <- map["products"]
    self.pagesCount <- map["number_pages"]
    self.page <- map["current_page"]
  }
}
