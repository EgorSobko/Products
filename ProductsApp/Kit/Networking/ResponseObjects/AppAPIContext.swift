//
//  AppAPIContext.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import ObjectMapper

public protocol APIContextProvider {
  
  var imageURLDomen: String? { get }
}

class AppAPIContext: Mappable, APIContextProvider {
  
  private(set) var imageURLDomen: String?
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    self.imageURLDomen <- map["image_url"]
  }
}
