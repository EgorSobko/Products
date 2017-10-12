//
//  Product.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import ObjectMapper

public class Product: Mappable {
  
  public private(set) var name: String?
  private(set) var priceString: String?
  public private(set) var thumbnailPath: String?
  public var price: Float? {
    return priceString.flatMap { Float($0) }
  }
  
  required convenience public init?(map: Map) {
    self.init()
  }
  
  public func mapping(map: Map) {
    self.name <- map["name"]
    self.priceString <- map["price"]
    self.thumbnailPath <- map["thumbnail_path"]
  }
}
