//
//  GetProductsRequest.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import Alamofire

class GetProductsRequest: RequestType {
  
  var path: String {
    return Constants.APIEndpoints.trendproducts
  }
  
  var parameters: [String: Any] {
    var tempParameters: [String: Any] = [:]
    tempParameters["store_id"] = storeId
    tempParameters["user_token"] = userToken
    tempParameters["app_token"] = appToken
    tempParameters["page_override"] = pageOverride

    return tempParameters
  }
  
  var responseSerializer: DataResponseSerializer<ProductResponse> {
    return EntitySerializer.objectSerializer()
  }
  
  private let appToken: String
  private let userToken: String
  private let storeId: Int
  private let pageOverride: Int
  
  init(appToken: String = Constants.API.token, credentials: Credentials, pageOverride: Int) {
    self.appToken = appToken
    self.userToken = credentials.userToken
    self.storeId = credentials.storeId
    self.pageOverride = pageOverride
  }
}
