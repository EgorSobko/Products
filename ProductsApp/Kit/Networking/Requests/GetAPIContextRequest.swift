//
//  GetAPIContextRequest.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import Alamofire

class GetAPIContextRequest: RequestType {
  
  var path: String {
    return Constants.APIEndpoints.apiContext
  }
  
  var parameters: [String: Any] {
    var tempParameters: [String: Any] = [:]
    tempParameters["store_id"] = storeId
    tempParameters["user_token"] = userToken
    tempParameters["app_token"] = appToken

    return tempParameters
  }
  
  var responseSerializer: DataResponseSerializer<AppAPIContext> {
    return EntitySerializer.objectSerializer()
  }
  
  private let appToken: String
  private let userToken: String?
  private let storeId: String?
  
  init(appToken: String = Constants.API.token, userToken: String?, storeId: String?) {
    self.appToken = appToken
    self.userToken = userToken
    self.storeId = storeId
  }
}
